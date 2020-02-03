open_project rtl_kernel/hardcloud_top_ex/hardcloud_top_ex.xpr
import_files -force -norecurse rtl_kernel/hardcloud_top_ex/imports
update_compile_order -fileset sources_1
source -notrace rtl_kernel/hardcloud_top_ex/imports/package_kernel.tcl
package_project rtl_kernel/hardcloud_top_ex/hardcloud_top hardcloud.org kernel hardcloud_top
package_xo -xo_path tmp/hardcloud_top.xo -kernel_name hardcloud_top -ip_directory rtl_kernel/hardcloud_top_ex/hardcloud_top -kernel_xml rtl_kernel/hardcloud_top_ex/imports/kernel.xml
quit
