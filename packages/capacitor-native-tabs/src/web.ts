import { WebPlugin } from '@capacitor/core';

import type { NativeTabsPlugin } from './definitions';

export class NativeTabsWeb extends WebPlugin implements NativeTabsPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
