#ifndef FLUTTER_PLUGIN_QRY_PLUGIN_H_
#define FLUTTER_PLUGIN_QRY_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace qry {

class QryPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  QryPlugin();

  virtual ~QryPlugin();

  // Disallow copy and assign.
  QryPlugin(const QryPlugin&) = delete;
  QryPlugin& operator=(const QryPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace qry

#endif  // FLUTTER_PLUGIN_QRY_PLUGIN_H_
