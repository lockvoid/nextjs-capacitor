import NextLink from 'next/link'
import { NativeNavigation } from "@lockvoid/capacitor-native-navigation";

const Link = ({ href, children, ...restProps }) => {

  return (
    <NextLink {...restProps} href={href}>
      {children}
    </NextLink> 
  )
}

export default Link;  
