{ pkgs, ... }:
{
  virtualisation.docker.enable = true;
  
  services = {
    postgresql = {
      enable = true;
      ensureDatabases = [ "sharkey" "image_tool_db" ];
      enableTCPIP = true;
      settings.port = 5432;
      package = pkgs.postgresql_14;
      authentication = pkgs.lib.mkOverride 10 ''
        #...
        #type database DBuser origin-address auth-method
        # ipv4
        host  all      all     127.0.0.1/32   trust
        # ipv6
        host all       all     ::1/128        trust
        local all all trust
      '';
      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE sharkey WITH LOGIN PASSWORD 'sharkey' CREATEDB;
        CREATE DATABASE sharkey;
        GRANT ALL PRIVILEGES ON DATABASE sharkey TO sharkey;

        CREATE ROLE imagetool WITH LOGIN PASSWORD 'password' CREATEDB;
        CREATE DATABASE image_tool_db;
        GRANT ALL PRIVILEGES ON DATABASE image_tool_db TO imagetool;
      '';
    };

    redis.servers."sharkey_redis".enable = true;
    redis.servers."sharkey_redis".port = 6379;
  };


  environment.variables.PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
  environment.variables.PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
  environment.variables.PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
}