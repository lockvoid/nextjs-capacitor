import NextLink from 'next/link'
import { NativeTabs } from "@lockvoid/capacitor-native-tabs";

const Link = ({ href, children, ...restProps }) => {
  const handlePush = (event) => {
    if (window.Capacitor.isNativePlatform()) {
      event.preventDefault();

      window.Capacitor.Plugins.NativeTabs.createTabs({ url: href });

      //NativeTabs.push({ url: href });
    }
  }

  return (
    <NextLink {...restProps} href={href} onClick={handlePush}>
      {children}
    </NextLink> 
  )
}

export default Link;  
