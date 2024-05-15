import NextLink from 'next/link'
import { NativeTabs } from "@lockvoid/capacitor-native-tabs";

const Link = ({ href, children, ...restProps }) => {

  return (
    <NextLink {...restProps} href={href}>
      {children}
    </NextLink> 
  )
}

export default Link;  
