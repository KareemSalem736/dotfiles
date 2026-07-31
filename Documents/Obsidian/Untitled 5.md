
No whitelist, everything in the user service
access-service -> grpc interceptor -> get user attributes -> get the roles (things like if theyre whitelisted) -> Set roles in RBAC - whitelisted - isAdmin -> User service does not define permissions, Access Service does -> user can get their own, system can get their own, if admin, 