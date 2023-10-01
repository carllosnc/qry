#include "include/qry/qry_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "qry_plugin.h"

void QryPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  qry::QryPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
