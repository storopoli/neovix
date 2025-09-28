{ ... }:

{
  plugins.avante = {
    enable = true;

    settings = {
      provider = "claude";
      # provider = "xai";
      auto_suggestions_provider = "claude";
    };
  };
}
