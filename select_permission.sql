-----https://stackoverflow.com/questions/7048839/sql-server-query-to-find-all-permissions-access-for-all-users-in-a-database
SELECT
        [UserType] = CASE princ.[type]
                         WHEN 'S' THEN 'SQL User'
                         WHEN 'U' THEN 'Windows User'
                         WHEN 'G' THEN 'Windows Group'
                     END,
        [DatabaseUserName] = princ.[name],
        [LoginName]        = ulogin.[name],
        [Role]             = NULL,
        [PermissionType]   = perm.[permission_name],
        [PermissionState]  = perm.[state_desc],
        [ObjectType] = CASE perm.[class]
                           WHEN 1 THEN obj.[type_desc]        -- Schema-contained objects
                           ELSE perm.[class_desc]             -- Higher-level objects
                       END,
        [Schema] = objschem.[name],
        [ObjectName] = CASE perm.[class]
                           WHEN 3 THEN permschem.[name]       -- Schemas
                           WHEN 4 THEN imp.[name]             -- Impersonations
                           ELSE OBJECT_NAME(perm.[major_id])  -- General objects
                       END,
        [ColumnName] = col.[name]
    FROM
        --Database user
        sys.database_principals            AS princ
        --Login accounts
        LEFT JOIN sys.user_token    AS ulogin    ON ulogin.[sid] = princ.[sid]
        --Permissions
        LEFT JOIN sys.database_permissions AS perm      ON perm.[grantee_principal_id] = princ.[principal_id]
        LEFT JOIN sys.schemas              AS permschem ON permschem.[schema_id] = perm.[major_id]
        LEFT JOIN sys.objects              AS obj       ON obj.[object_id] = perm.[major_id]
        LEFT JOIN sys.schemas              AS objschem  ON objschem.[schema_id] = obj.[schema_id]
        --Table columns
        LEFT JOIN sys.columns              AS col       ON col.[object_id] = perm.[major_id]
                                                           AND col.[column_id] = perm.[minor_id]
        --Impersonations
        LEFT JOIN sys.database_principals  AS imp       ON imp.[principal_id] = perm.[major_id]
    WHERE
        princ.[type] IN ('S','U','G')
        -- No need for these system accounts
        AND princ.[name] NOT IN ('sys', 'INFORMATION_SCHEMA')

UNION

    --2) List all access provisioned to a SQL user or Windows user/group through a database or application role
    SELECT
        [UserType] = CASE membprinc.[type]
                         WHEN 'S' THEN 'SQL User'
                         WHEN 'U' THEN 'Windows User'
                         WHEN 'G' THEN 'Windows Group'
                     END,
        [DatabaseUserName] = membprinc.[name],
        [LoginName]        = ulogin.[name],
        [Role]             = roleprinc.[name],
        [PermissionType]   = perm.[permission_name],
        [PermissionState]  = perm.[state_desc],
        [ObjectType] = CASE perm.[class]
                           WHEN 1 THEN obj.[type_desc]        -- Schema-contained objects
                           ELSE perm.[class_desc]             -- Higher-level objects
                       END,
        [Schema] = objschem.[name],
        [ObjectName] = CASE perm.[class]
                           WHEN 3 THEN permschem.[name]       -- Schemas
                           WHEN 4 THEN imp.[name]             -- Impersonations
                           ELSE OBJECT_NAME(perm.[major_id])  -- General objects
                       END,
        [ColumnName] = col.[name]
    FROM
        --Role/member associations
        sys.database_role_members          AS members
        --Roles
        JOIN      sys.database_principals  AS roleprinc ON roleprinc.[principal_id] = members.[role_principal_id]
        --Role members (database users)
        JOIN      sys.database_principals  AS membprinc ON membprinc.[principal_id] = members.[member_principal_id]
        --Login accounts
        LEFT JOIN sys.user_token    AS ulogin    ON ulogin.[sid] = membprinc.[sid]
        --Permissions
        LEFT JOIN sys.database_permissions AS perm      ON perm.[grantee_principal_id] = roleprinc.[principal_id]
        LEFT JOIN sys.schemas              AS permschem ON permschem.[schema_id] = perm.[major_id]
        LEFT JOIN sys.objects              AS obj       ON obj.[object_id] = perm.[major_id]
        LEFT JOIN sys.schemas              AS objschem  ON objschem.[schema_id] = obj.[schema_id]
        --Table columns
        LEFT JOIN sys.columns              AS col       ON col.[object_id] = perm.[major_id]
                                                           AND col.[column_id] = perm.[minor_id]
        --Impersonations
        LEFT JOIN sys.database_principals  AS imp       ON imp.[principal_id] = perm.[major_id]
    WHERE
        membprinc.[type] IN ('S','U','G')
        -- No need for these system accounts
        AND membprinc.[name] NOT IN ('sys', 'INFORMATION_SCHEMA')

UNION

    --3) List all access provisioned to the public role, which everyone gets by default
    SELECT
        [UserType]         = '{All Users}',
        [DatabaseUserName] = '{All Users}',
        [LoginName]        = '{All Users}',
        [Role]             = roleprinc.[name],
        [PermissionType]   = perm.[permission_name],
        [PermissionState]  = perm.[state_desc],
        [ObjectType] = CASE perm.[class]
                           WHEN 1 THEN obj.[type_desc]        -- Schema-contained objects
                           ELSE perm.[class_desc]             -- Higher-level objects
                       END,
        [Schema] = objschem.[name],
        [ObjectName] = CASE perm.[class]
                           WHEN 3 THEN permschem.[name]       -- Schemas
                           WHEN 4 THEN imp.[name]             -- Impersonations
                           ELSE OBJECT_NAME(perm.[major_id])  -- General objects
                       END,
        [ColumnName] = col.[name]
    FROM
        --Roles
        sys.database_principals            AS roleprinc
        --Role permissions
        LEFT JOIN sys.database_permissions AS perm      ON perm.[grantee_principal_id] = roleprinc.[principal_id]
        LEFT JOIN sys.schemas              AS permschem ON permschem.[schema_id] = perm.[major_id]
        --All objects
        JOIN      sys.objects              AS obj       ON obj.[object_id] = perm.[major_id]
        LEFT JOIN sys.schemas              AS objschem  ON objschem.[schema_id] = obj.[schema_id]
        --Table columns
        LEFT JOIN sys.columns              AS col       ON col.[object_id] = perm.[major_id]
                                                           AND col.[column_id] = perm.[minor_id]
        --Impersonations
        LEFT JOIN sys.database_principals  AS imp       ON imp.[principal_id] = perm.[major_id]
    WHERE
        roleprinc.[type] = 'R'
        AND roleprinc.[name] = 'public'
        AND obj.[is_ms_shipped] = 0

ORDER BY
    [UserType],
    [DatabaseUserName],
    [LoginName],
    [Role],
    [Schema],
    [ObjectName],
    [ColumnName],
    [PermissionType],
    [PermissionState],
    [ObjectType]

--------------------------------------------------------------------------------------------------------------------------------
---- for table and schema
	SELECT  
    [UserName] = ulogin.[name],
    [UserType] = CASE princ.[type]
                    WHEN 'S' THEN 'SQL User'
                    WHEN 'U' THEN 'Windows User'
                    WHEN 'G' THEN 'Windows Group'
                 END,  
    [DatabaseUserName] = princ.[name],       
    [Role] = null,      
    [PermissionType] = perm.[permission_name],       
    [PermissionState] = perm.[state_desc],       
    [ObjectType] = CASE perm.[class] 
                        WHEN 1 THEN obj.type_desc               -- Schema-contained objects
                        ELSE perm.[class_desc]                  -- Higher-level objects
                   END,       
    [ObjectName] = CASE perm.[class] 
                        WHEN 1 THEN OBJECT_NAME(perm.major_id)  -- General objects
                        WHEN 3 THEN schem.[name]                -- Schemas
                        WHEN 4 THEN imp.[name]                  -- Impersonations
                   END,
    [ColumnName] = col.[name]
FROM    
    --database user
    sys.database_principals princ  
LEFT JOIN
    --Login accounts
    sys.user_token ulogin on princ.[sid] = ulogin.[sid]
LEFT JOIN        
    --Permissions
    sys.database_permissions perm ON perm.[grantee_principal_id] = princ.[principal_id]
LEFT JOIN
    --Table columns
    sys.columns col ON col.[object_id] = perm.major_id 
                    AND col.[column_id] = perm.[minor_id]
LEFT JOIN
    sys.objects obj ON perm.[major_id] = obj.[object_id]
LEFT JOIN
    sys.schemas schem ON schem.[schema_id] = perm.[major_id]
LEFT JOIN
    sys.database_principals imp ON imp.[principal_id] = perm.[major_id]
WHERE 
    princ.[type] IN ('S','U','G') AND
    -- No need for these system accounts
    princ.[name] NOT IN ('sys', 'INFORMATION_SCHEMA')


-----------------
select  princ.name
,       princ.type_desc
,       perm.permission_name
,       perm.state_desc
,       perm.class_desc
,       object_name(perm.major_id)
from    sys.database_principals princ
left join
        sys.database_permissions perm
on      perm.grantee_principal_id = princ.principal_id
where princ.name='gosesdeid901' or princ.name='gosesdeid902'

-----------------
SELECT state_desc, permission_name, 'ON', class_desc,
SCHEMA_NAME(major_id),
'TO', USER_NAME(grantee_principal_id)
FROM sys.database_permissions AS Perm
JOIN sys.database_principals AS Prin
ON Perm.major_ID = Prin.principal_id AND class_desc = 'SCHEMA'
WHERE major_id = SCHEMA_ID('schemaname')
AND grantee_principal_id = user_id('username')
