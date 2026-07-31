
No whitelist, everything in the user service
access-service -> grpc interceptor -> get user attributes -> get the roles (things like if theyre whitelisted) -> Set roles in RBAC - whitelisted - isAdmin