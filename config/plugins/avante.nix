{ ... }:

{
  plugins = {
    avante = {
      enable = true;

      settings = {
        provider = "claude-code";
        # provider = "xai";
        auto_suggestions_provider = "claude";
        file_selector = {
          provider = "fzf-lua";
        };
        web_search_engine = {
          provider = "kagi";
        };
        behaviour = {
          enable_fastapply = true;
        };
      };
    };
    img-clip = {
      enable = true;

      settings = {
        default = {
          embed_image_as_base64 = false;
          prompt_for_file_name = false;
          drag_and_drop = {
            insert_mode = true;
          };
          # required for Windows users
          use_absolute_path = true;
        };
      };
    };
  };
}
