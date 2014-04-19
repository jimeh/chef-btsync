name             "btsync"
maintainer       "Jim Myhrberg"
maintainer_email "contact@jimeh.me"
license          "MIT"
description      "Install and configure BTSync."
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.1.0"
recipe           "btsync", "Installs, configures, and launches BTSync."
recipe           "btsync::install", "Installs BTSync."
recipe           "btsync::configure", "Configures BTSync."
supports         "ubuntu"

attribute("btsync",
  :display_name => "BTSync Hash",
  :description  => "Hash of BTSync attributes",
  :type         => "hash")
