OSU::AccessPolicy.register(User, UserAccessPolicy)
OSU::AccessPolicy.register(UserGroup, UserGroupAccessPolicy)
OSU::AccessPolicy.register(Doorkeeper::Application,
                           Doorkeeper::ApplicationAccessPolicy)