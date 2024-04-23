export interface NativeTabsPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
