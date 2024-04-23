import { registerPlugin } from '@capacitor/core';

import type { NativeTabsPlugin } from './definitions';

const NativeTabs = registerPlugin<NativeTabsPlugin>('NativeTabs', {
  web: () => import('./web').then(m => new m.NativeTabsWeb()),
});

export * from './definitions';
export { NativeTabs };
