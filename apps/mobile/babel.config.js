module.exports = function (api) {
  api.cache(true);
  return {
    // NativeWind v4: the `nativewind/babel` preset (react-native-css-interop)
    // already configures the JSX transform with importSource
    // "react-native-css-interop". Do NOT also set jsxImportSource:'nativewind'
    // on babel-preset-expo — it overrides that and silently disables className,
    // leaving the whole app unstyled.
    presets: ['babel-preset-expo', 'nativewind/babel'],
  };
};
