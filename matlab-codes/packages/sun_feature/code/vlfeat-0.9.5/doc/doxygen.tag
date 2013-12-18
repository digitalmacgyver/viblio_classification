<?xml version='1.0' encoding='ISO-8859-1' standalone='yes' ?>
<tagfile>
  <compound kind="page">
    <name>index</name>
    <title>VLFeat -- Vision Lab Features Library</title>
    <filename>index</filename>
    <docanchor file="index">design-threads</docanchor>
    <docanchor file="index">design-portability</docanchor>
    <docanchor file="index">main-glossary</docanchor>
    <docanchor file="index">design-resources</docanchor>
    <docanchor file="index">design-objects</docanchor>
    <docanchor file="index">design</docanchor>
    <docanchor file="index">main-contents</docanchor>
  </compound>
  <compound kind="file">
    <name>aib.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>aib_8c</filename>
    <includes id="aib_8h" name="aib.h" local="yes" imported="no">aib.h</includes>
    <member kind="function">
      <type>void</type>
      <name>vl_aib_normalize_P</name>
      <anchorfile>aib_8c.html</anchorfile>
      <anchor>14bc24cb8ad409132d16de6e3f27b002</anchor>
      <arglist>(double *P, vl_uint nelem)</arglist>
    </member>
    <member kind="function">
      <type>vl_uint *</type>
      <name>vl_aib_new_nodelist</name>
      <anchorfile>aib_8c.html</anchorfile>
      <anchor>f4a8a12f8fa47997c140b43cd993dc30</anchor>
      <arglist>(vl_uint nentries)</arglist>
    </member>
    <member kind="function">
      <type>double *</type>
      <name>vl_aib_new_Px</name>
      <anchorfile>aib_8c.html</anchorfile>
      <anchor>9b903a69b8d1167f48cfe1e00a9e1d33</anchor>
      <arglist>(double *Pcx, vl_uint nvalues, vl_uint nlabels)</arglist>
    </member>
    <member kind="function">
      <type>double *</type>
      <name>vl_aib_new_Pc</name>
      <anchorfile>aib_8c.html</anchorfile>
      <anchor>171cd4a6e0622a97286a0a2b2130841c</anchor>
      <arglist>(double *Pcx, vl_uint nvalues, vl_uint nlabels)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>vl_aib_min_beta</name>
      <anchorfile>aib_8c.html</anchorfile>
      <anchor>a567101e4f0835b9a73a9b037afa0953</anchor>
      <arglist>(VlAIB *aib, vl_uint *besti, vl_uint *bestj, double *minbeta)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>vl_aib_merge_nodes</name>
      <anchorfile>aib_8c.html</anchorfile>
      <anchor>4b04bbe5d45b4a9fd84aecb173fbab93</anchor>
      <arglist>(VlAIB *aib, vl_uint i, vl_uint j, vl_uint new)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>vl_aib_update_beta</name>
      <anchorfile>aib_8c.html</anchorfile>
      <anchor>474eae5c9436f86251eea120221e8bd1</anchor>
      <arglist>(VlAIB *aib)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>vl_aib_calculate_information</name>
      <anchorfile>aib_8c.html</anchorfile>
      <anchor>531a6f39064384f6728df5a1641d7f54</anchor>
      <arglist>(VlAIB *aib, double *I, double *H)</arglist>
    </member>
    <member kind="function">
      <type>VlAIB *</type>
      <name>vl_aib_new</name>
      <anchorfile>aib_8c.html</anchorfile>
      <anchor>4bb02325ebe150348976dbb46183f8f3</anchor>
      <arglist>(double *Pcx, vl_uint nvalues, vl_uint nlabels)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>vl_aib_delete</name>
      <anchorfile>aib_8c.html</anchorfile>
      <anchor>145bb0e2d8f512613e8fd3fb92fe7ace</anchor>
      <arglist>(VlAIB *aib)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_aib_process</name>
      <anchorfile>aib_8c.html</anchorfile>
      <anchor>9512d915c4b42026113274dacfab3df2</anchor>
      <arglist>(VlAIB *aib)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>aib.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>aib_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <includes id="mathop_8h" name="mathop.h" local="yes" imported="no">mathop.h</includes>
    <class kind="struct">_VlAIB</class>
    <member kind="typedef">
      <type>struct _VlAIB</type>
      <name>VlAIB</name>
      <anchorfile>aib_8h.html</anchorfile>
      <anchor>22f6ce16e17f4a9908c2abadc1acfb5f</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlAIB *</type>
      <name>vl_aib_new</name>
      <anchorfile>aib_8h.html</anchorfile>
      <anchor>51ae009a477fa6da30193567703dc908</anchor>
      <arglist>(double *Pcx, vl_uint nvalues, vl_uint nlabels)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_aib_delete</name>
      <anchorfile>aib_8h.html</anchorfile>
      <anchor>ef5b4ebd2cb6d4102014bf4a9032f678</anchor>
      <arglist>(VlAIB *aib)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_aib_process</name>
      <anchorfile>aib_8h.html</anchorfile>
      <anchor>9512d915c4b42026113274dacfab3df2</anchor>
      <arglist>(VlAIB *aib)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_uint *</type>
      <name>vl_aib_get_parents</name>
      <anchorfile>aib_8h.html</anchorfile>
      <anchor>bb1fae94a63c1b5b314a54a73db6132a</anchor>
      <arglist>(VlAIB const *aib)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double *</type>
      <name>vl_aib_get_costs</name>
      <anchorfile>aib_8h.html</anchorfile>
      <anchor>0c19cfc121aa4eff6b4ccd58a2168d5c</anchor>
      <arglist>(VlAIB const *aib)</arglist>
    </member>
    <docanchor file="aib_8h">aib-algorithm</docanchor>
    <docanchor file="aib_8h">aib-overview</docanchor>
  </compound>
  <compound kind="file">
    <name>dsift.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>dsift_8c</filename>
    <includes id="dsift_8h" name="dsift.h" local="yes" imported="no">dsift.h</includes>
    <includes id="pgm_8h" name="pgm.h" local="yes" imported="no">pgm.h</includes>
    <member kind="function">
      <type>float *</type>
      <name>_vl_dsift_new_kernel</name>
      <anchorfile>dsift_8c.html</anchorfile>
      <anchor>9a99d480cf025b9f19cc3e3ee5b010c4</anchor>
      <arglist>(int binSize, int numBins, int binIndex, double windowSize)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE float</type>
      <name>_vl_dsift_normalize_histogram</name>
      <anchorfile>dsift_8c.html</anchorfile>
      <anchor>1a8319889b1833c105817eeb07f85675</anchor>
      <arglist>(float *begin, float *end)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>_vl_dsift_free_buffers</name>
      <anchorfile>dsift_8c.html</anchorfile>
      <anchor>85a2ddc18108b83931d3cb7c66e7b382</anchor>
      <arglist>(VlDsiftFilter *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>_vl_dsift_update_buffers</name>
      <anchorfile>dsift_8c.html</anchorfile>
      <anchor>dd71202b9bea63e4ef0e7e6450d28469</anchor>
      <arglist>(VlDsiftFilter *self)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>_vl_dsift_alloc_buffers</name>
      <anchorfile>dsift_8c.html</anchorfile>
      <anchor>8b3119bdf4dd078826d1fa70231184fe</anchor>
      <arglist>(VlDsiftFilter *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlDsiftFilter *</type>
      <name>vl_dsift_new</name>
      <anchorfile>dsift_8c.html</anchorfile>
      <anchor>5dc43589ca865d698cf09c60b2e19259</anchor>
      <arglist>(int imWidth, int imHeight)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlDsiftFilter *</type>
      <name>vl_dsift_new_basic</name>
      <anchorfile>dsift_8c.html</anchorfile>
      <anchor>ad78f3b3661c1cd199839fb86c0838f3</anchor>
      <arglist>(int imWidth, int imHeight, int step, int binSize)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_dsift_delete</name>
      <anchorfile>dsift_8c.html</anchorfile>
      <anchor>513d16efd29e795f6affb1dc55344b35</anchor>
      <arglist>(VlDsiftFilter *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>_vl_dsift_with_gaussian_window</name>
      <anchorfile>dsift_8c.html</anchorfile>
      <anchor>454f20230291e23285448813b230a0eb</anchor>
      <arglist>(VlDsiftFilter *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>_vl_dsift_with_flat_window</name>
      <anchorfile>dsift_8c.html</anchorfile>
      <anchor>c06773b962840055b60556491d7b059e</anchor>
      <arglist>(VlDsiftFilter *self)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>vl_dsift_process</name>
      <anchorfile>dsift_8c.html</anchorfile>
      <anchor>09d5525ad7e16e2b9f3f1b9d273c85f6</anchor>
      <arglist>(VlDsiftFilter *self, float const *im)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>dsift.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>dsift_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <class kind="struct">VlDsiftKeypoint_</class>
    <class kind="struct">VlDsiftDescriptorGeometry_</class>
    <class kind="struct">VlDsiftFilter_</class>
    <member kind="typedef">
      <type>struct VlDsiftKeypoint_</type>
      <name>VlDsiftKeypoint</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>32095fa2dbadd257d7a479ded7b68fe5</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct VlDsiftDescriptorGeometry_</type>
      <name>VlDsiftDescriptorGeometry</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>d38d2f2bda45dbe9e09109e28e2edfde</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct VlDsiftFilter_</type>
      <name>VlDsiftFilter</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>a92806a5761bca999917e9e352747730</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlDsiftFilter *</type>
      <name>vl_dsift_new</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>7cf3c57331ccafb453b37b0c5736b945</anchor>
      <arglist>(int width, int height)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlDsiftFilter *</type>
      <name>vl_dsift_new_basic</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>8709d5f69c90b0ddd0a5b9151e075369</anchor>
      <arglist>(int width, int height, int step, int binSize)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_dsift_delete</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>513d16efd29e795f6affb1dc55344b35</anchor>
      <arglist>(VlDsiftFilter *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_dsift_process</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>e2ae602b4923cbc79f8a4ed211f92f85</anchor>
      <arglist>(VlDsiftFilter *self, float const *im)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_dsift_transpose_descriptor</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>7f2af4547db71e3f71882c2e14e1ed80</anchor>
      <arglist>(float *dst, float const *src, int numBinT, int numBinX, int numBinY)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>_vl_dsift_update_buffers</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>dd71202b9bea63e4ef0e7e6450d28469</anchor>
      <arglist>(VlDsiftFilter *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_dsift_set_steps</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>42ae6bf77a9b737fd1e45ad5c43263dd</anchor>
      <arglist>(VlDsiftFilter *self, int stepX, int stepY)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_dsift_set_bounds</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>7d34c8e257c873f2ed580b046296d1ac</anchor>
      <arglist>(VlDsiftFilter *self, int minX, int minY, int maxX, int maxY)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_dsift_set_geometry</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>930f20c25eab08d9490830b0a358ff2b</anchor>
      <arglist>(VlDsiftFilter *self, VlDsiftDescriptorGeometry const *geom)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_dsift_set_flat_window</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>91f319a3e3558f7491634f78a9b1713b</anchor>
      <arglist>(VlDsiftFilter *self, int useFlatWindow)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_dsift_set_window_size</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>e60fa31ff4df09e8025525714dac9563</anchor>
      <arglist>(VlDsiftFilter *self, double windowSize)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE float const *</type>
      <name>vl_dsift_get_descriptors</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>cd5425e9764383a5ef05bce00fd40e94</anchor>
      <arglist>(VlDsiftFilter const *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_dsift_get_descriptor_size</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>eade8b18c21954f00d76f5dcb12b9bfe</anchor>
      <arglist>(VlDsiftFilter const *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_dsift_get_keypoint_num</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>3b5fabb1496fc91a70669d4201f47a5b</anchor>
      <arglist>(VlDsiftFilter const *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE VlDsiftKeypoint const *</type>
      <name>vl_dsift_get_keypoints</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>0cba85e88ae5232fe74368175a8ba510</anchor>
      <arglist>(VlDsiftFilter const *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_dsift_get_bounds</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>e6847be5d2204f06551e12c4a2a84990</anchor>
      <arglist>(VlDsiftFilter const *self, int *minX, int *minY, int *maxX, int *maxY)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_dsift_get_steps</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>aae1634a166ab5a61d89236fa5bf04d3</anchor>
      <arglist>(VlDsiftFilter const *self, int *stepX, int *stepY)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE VlDsiftDescriptorGeometry const *</type>
      <name>vl_dsift_get_geometry</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>55eb4068cd76b03c3bb120a895b7ed13</anchor>
      <arglist>(VlDsiftFilter const *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_bool</type>
      <name>vl_dsift_get_flat_window</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>2f20d74d4250ebf12dc80235a31a64b6</anchor>
      <arglist>(VlDsiftFilter const *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_dsift_get_window_size</name>
      <anchorfile>dsift_8h.html</anchorfile>
      <anchor>ccc84f1fe321e07b09f90ca45a03dcb7</anchor>
      <arglist>(VlDsiftFilter const *self)</arglist>
    </member>
    <docanchor file="dsift_8h">dsift</docanchor>
    <docanchor file="dsift_8h">dsift-usage</docanchor>
    <docanchor file="dsift_8h">dsift-intro</docanchor>
    <docanchor file="dsift_8h">dsift-tech</docanchor>
    <docanchor file="dsift_8h">dsift-tech-descriptor-dense</docanchor>
    <docanchor file="dsift_8h">dsift-tech-sampling</docanchor>
  </compound>
  <compound kind="file">
    <name>generic.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>generic_8c</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <member kind="function">
      <type>VL_EXPORT char const *</type>
      <name>vl_get_version_string</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>cbbb002e31f178d0fd1a1e87294cbf1e</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_print_info</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>7c42b07da4189a6d72cb757e751902e5</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>do_nothing_printf</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>d4772f51849960d0d88e434a157fbceb</anchor>
      <arglist>(char const *format,...)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_set_alloc_func</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>3a951cf8cf7028299be1a52e0cb2d9cc</anchor>
      <arglist>(void *(*malloc_func)(size_t), void *(*realloc_func)(void *, size_t), void *(*calloc_func)(size_t, size_t), void(*free_func)(void *))</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_set_printf_func</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>defdaf2e63cd809cbb4e254cd205a1b1</anchor>
      <arglist>(printf_func_t printf_func)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>vl_tic</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>0eb9d2de6dc4cb6570db6bb3e8c39244</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>double</type>
      <name>vl_toc</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>6570090509ab5a156a24e2bbd082590d</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT int</type>
      <name>vl_err_no</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>e6050ca9ffb81385076cc0e1cc6c60db</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT char</type>
      <name>vl_err_msg</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>5bf26cec05189b422d6ca7af8a731327</anchor>
      <arglist>[VL_ERR_MSG_LEN+1]</arglist>
    </member>
    <member kind="variable">
      <type>void *(*</type>
      <name>vl_malloc_func</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>68b72037d7d3a5b5fad07923563c0cd0</anchor>
      <arglist>)(size_t)</arglist>
    </member>
    <member kind="variable">
      <type>void *(*</type>
      <name>vl_realloc_func</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>1cea507b4ded2cadf134b6518afa6dec</anchor>
      <arglist>)(void *, size_t)</arglist>
    </member>
    <member kind="variable">
      <type>void *(*</type>
      <name>vl_calloc_func</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>21d18c0a5127511f19bdf470c13f9cf3</anchor>
      <arglist>)(size_t, size_t)</arglist>
    </member>
    <member kind="variable">
      <type>void(*</type>
      <name>vl_free_func</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>d2029df53529308b43bd2f88a6a6d2d0</anchor>
      <arglist>)(void *)</arglist>
    </member>
    <member kind="variable">
      <type>int(*</type>
      <name>vl_printf_func</name>
      <anchorfile>generic_8c.html</anchorfile>
      <anchor>e349975de4b840fc4659323b631bd9c6</anchor>
      <arglist>)(char const *,...)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>generic.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>generic_8h</filename>
    <includes id="host_8h" name="host.h" local="yes" imported="no">host.h</includes>
    <member kind="define">
      <type>#define</type>
      <name>VL_VERSION_STRING</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>a53b45e68c7ce79c6fc539e64ba027a6</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_YESNO</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>ddfdc610a7c5d53f5167f7a02b5baf4f</anchor>
      <arglist>(x)</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_STRINGIFY</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>61a48096b951544d0554b8a06aa59306</anchor>
      <arglist>(x)</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_XSTRINGIFY</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>2a5d283f40e6bf0fc1ca74644084a423</anchor>
      <arglist>(x)</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_CAT</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>eba7ee97f4e6474a78c242ca9c49798c</anchor>
      <arglist>(x, y)</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_XCAT</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>755f8d9673970b82ad9375e32d2693ef</anchor>
      <arglist>(x, y)</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_TYPE_FLOAT</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>a034d0b942f9800b2a02aeb30ff10fa2</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_TYPE_DOUBLE</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>41d6691dac0cc3648ca9701d27e5d2b0</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_TYPE_INT8</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>90ea396337523c32c3022f358196ccc9</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_TYPE_UINT8</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>4db234bb60c94d6f562f8e9ce3b1795e</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_TYPE_INT16</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>4eb25b91045f880c1d10e609174d3f5c</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_TYPE_UINT16</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>2e47aef4fdd2aa9f388fd2adfc36f4b1</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_TYPE_INT32</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>4ca0c2adc987dcb7f57a7de7893f5b7c</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_TYPE_UINT32</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>c1ca77a71afce483185fbd23f4df9ec7</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_TYPE_INT64</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>873cea95408414b33bc0d0af250caf5e</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_TYPE_UINT64</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>ce055d33cb1d7f213bfc0b3a55b86fa2</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_MIN</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>36f2f85796040ca2f71bb34a9f55969f</anchor>
      <arglist>(x, y)</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_MAX</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>c8a3f4020a3e381daadd4214668dc63c</anchor>
      <arglist>(x, y)</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_SHIFT_LEFT</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>ee17b425e4672e582e26cf9e103fc0fb</anchor>
      <arglist>(x, n)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT char const *</type>
      <name>vl_get_version_string</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>cbbb002e31f178d0fd1a1e87294cbf1e</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_print_info</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>7c42b07da4189a6d72cb757e751902e5</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_set_alloc_func</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>3a951cf8cf7028299be1a52e0cb2d9cc</anchor>
      <arglist>(void *(*malloc_func)(size_t), void *(*realloc_func)(void *, size_t), void *(*calloc_func)(size_t, size_t), void(*free_func)(void *))</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void *</type>
      <name>vl_malloc</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>e28d261fc7cc26f1457b171d842b53ab</anchor>
      <arglist>(size_t n)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void *</type>
      <name>vl_realloc</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>e39d0b3bbe1fc3402febdbab894f2207</anchor>
      <arglist>(void *ptr, size_t n)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void *</type>
      <name>vl_calloc</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>93ff990a07af5b4b69bbde7c8e021e28</anchor>
      <arglist>(size_t n, size_t size)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_free</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>bb97ff524f46d6c5ce9ca8af9e792cc3</anchor>
      <arglist>(void *ptr)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_tic</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>8b1724fe5fe0f30b0ace47acd205f431</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT double</type>
      <name>vl_toc</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>517bfafb7acdac760a0d8f1aab5bcdb7</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT int(*</type>
      <name>vl_printf_func</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>cc38b2befc2759dcfa8a4bdb910ab993</anchor>
      <arglist>)(char const *format,...)</arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT void *(*</type>
      <name>vl_malloc_func</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>19d349174cfffe4c53fae91dbb131cf4</anchor>
      <arglist>)(size_t)</arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT void *(*</type>
      <name>vl_realloc_func</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>82785faf059985a710fb075aecfd5d99</anchor>
      <arglist>)(void *, size_t)</arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT void *(*</type>
      <name>vl_calloc_func</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>911ecb8e12a81b200e89e4ded4631feb</anchor>
      <arglist>)(size_t, size_t)</arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT void(*</type>
      <name>vl_free_func</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>308ea0f0f9c849f6141e2695cdf26c18</anchor>
      <arglist>)(void *)</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_PRINTF</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>f68d1c6327bf2226b15c84007eab3d94</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_PRINT</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>1d4b7e68329e078b0d9064b7f408c96b</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>int(*</type>
      <name>printf_func_t</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>bed0f89efbee38c21c99d2967bab01c1</anchor>
      <arglist>)(char const *format,...)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_set_printf_func</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>defdaf2e63cd809cbb4e254cd205a1b1</anchor>
      <arglist>(printf_func_t printf_func)</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_ERR_MSG_LEN</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>f35e10968d642caab4fbffe6f4b0789c</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_ERR_OK</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>26519a3dd2966d2d46538eb46921abba</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_ERR_OVERFLOW</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>ad375cc4dcec5d098a94d072b6c5b3d4</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_ERR_ALLOC</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>0a05979eb0e5e1bb8edd1d6992d73f5f</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_ERR_BAD_ARG</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>a4c6982fd95a25fca8ec202632581345</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_ERR_IO</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>ba78f9bc7029f3e8f69e502ef10a1ea2</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_ERR_EOF</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>67cc69e40d7af2aec137b36e53422982</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_ERR_NO_MORE</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>28c5e84bca772be393e834dfff61b22d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT int</type>
      <name>vl_err_no</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>e6050ca9ffb81385076cc0e1cc6c60db</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT char</type>
      <name>vl_err_msg</name>
      <anchorfile>generic_8h.html</anchorfile>
      <anchor>5bf26cec05189b422d6ca7af8a731327</anchor>
      <arglist>[VL_ERR_MSG_LEN+1]</arglist>
    </member>
    <docanchor file="generic_8h">generic-error</docanchor>
    <docanchor file="generic_8h">generic-logging</docanchor>
    <docanchor file="generic_8h">generic-time</docanchor>
    <docanchor file="generic_8h">generic-memory</docanchor>
    <docanchor file="generic_8h">generic-preproc</docanchor>
  </compound>
  <compound kind="file">
    <name>getopt_long.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>getopt__long_8c</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <includes id="getopt__long_8h" name="getopt_long.h" local="yes" imported="no">getopt_long.h</includes>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>getopt_long</name>
      <anchorfile>getopt__long_8c.html</anchorfile>
      <anchor>a3697e0a2c2656ceadadea4677e46730</anchor>
      <arglist>(int argc, char *const argv[], const char *optstring, const struct option *longopts, int *longindex)</arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT int</type>
      <name>optind</name>
      <anchorfile>getopt__long_8c.html</anchorfile>
      <anchor>90192dad337ffa282f4ee6685b22e44c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT int</type>
      <name>optopt</name>
      <anchorfile>getopt__long_8c.html</anchorfile>
      <anchor>2c619b8eb1760291fedf3e7b693f89e7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT char *</type>
      <name>optarg</name>
      <anchorfile>getopt__long_8c.html</anchorfile>
      <anchor>850d62c8bf5d6f6d9b92cd86a00d6739</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT int</type>
      <name>optreset</name>
      <anchorfile>getopt__long_8c.html</anchorfile>
      <anchor>f5bfe44c46bdda657353f4fb2f93caa4</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>getopt_long.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>getopt__long_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <class kind="struct">option</class>
    <member kind="define">
      <type>#define</type>
      <name>no_argument</name>
      <anchorfile>getopt__long_8h.html</anchorfile>
      <anchor>3bc1d5f667b5b4ca4b4abb685dc874ce</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>required_argument</name>
      <anchorfile>getopt__long_8h.html</anchorfile>
      <anchor>6ece8d8dfa8378778f7290fdaba5b8bc</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>optional_argument</name>
      <anchorfile>getopt__long_8h.html</anchorfile>
      <anchor>cca06c0a947656bd8b395bf1084ffb72</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>getopt_long</name>
      <anchorfile>getopt__long_8h.html</anchorfile>
      <anchor>a3697e0a2c2656ceadadea4677e46730</anchor>
      <arglist>(int argc, char *const argv[], const char *optstring, const struct option *longopts, int *longindex)</arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT int</type>
      <name>optind</name>
      <anchorfile>getopt__long_8h.html</anchorfile>
      <anchor>90192dad337ffa282f4ee6685b22e44c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT int</type>
      <name>optopt</name>
      <anchorfile>getopt__long_8h.html</anchorfile>
      <anchor>2c619b8eb1760291fedf3e7b693f89e7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT char *</type>
      <name>optarg</name>
      <anchorfile>getopt__long_8h.html</anchorfile>
      <anchor>850d62c8bf5d6f6d9b92cd86a00d6739</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VL_EXPORT int</type>
      <name>optreset</name>
      <anchorfile>getopt__long_8h.html</anchorfile>
      <anchor>f5bfe44c46bdda657353f4fb2f93caa4</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>heap-t.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>heap-t_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <includes id="heap_8h" name="heap.h" local="yes" imported="no">heap.h</includes>
    <member kind="function">
      <type>VL_INLINE void VL_HEAP_SWAP()</type>
      <name>NAME</name>
      <anchorfile>heap-t_8h.html</anchorfile>
      <anchor>7fe3b2c381aca62dabbede176a073ba9</anchor>
      <arglist>(T *a, T *b)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE</type>
      <name>void</name>
      <anchorfile>heap-t_8h.html</anchorfile>
      <anchor>5ea427ec0068c99eda1618637a522402</anchor>
      <arglist>(T *nodeArray, int unsigned numNodes, int unsigned nodeIndex)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE</type>
      <name>void</name>
      <anchorfile>heap-t_8h.html</anchorfile>
      <anchor>420554a2c382cf31b8b43c1c9601eccb</anchor>
      <arglist>(T *nodeArray, int unsigned nodeIndex)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE</type>
      <name>void</name>
      <anchorfile>heap-t_8h.html</anchorfile>
      <anchor>75a0e63bcde0854d6d2e18e1156c1b5b</anchor>
      <arglist>(T *nodeArray, int unsigned *numNodes)</arglist>
    </member>
    <member kind="variable">
      <type>VL_INLINE T *T *</type>
      <name>nodeArray</name>
      <anchorfile>heap-t_8h.html</anchorfile>
      <anchor>c3ea6371db6267bd726763dd99566729</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>heap.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>heap_8c</filename>
    <includes id="heap_8h" name="heap.h" local="yes" imported="no">heap.h</includes>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_heap_set_swap_func</name>
      <anchorfile>heap_8c.html</anchorfile>
      <anchor>eb495a03dbc0be0030fe9663cdde3507</anchor>
      <arglist>(VlHeap *self, void(*swap)(void *custom, void *a, void *b), void *customData)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlHeap *</type>
      <name>vl_heap_new</name>
      <anchorfile>heap_8c.html</anchorfile>
      <anchor>bb47c19977bcd9dd7f651fee4095035c</anchor>
      <arglist>(void *nodes, int nodeSize, int(*compare)(void const *a, void const *b))</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_heap_delete</name>
      <anchorfile>heap_8c.html</anchorfile>
      <anchor>b5958212f5b6706188d37bf65d5dfa47</anchor>
      <arglist>(VlHeap *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_heap_down</name>
      <anchorfile>heap_8c.html</anchorfile>
      <anchor>17e803d76606a270dc3c2d8b4388c0c8</anchor>
      <arglist>(VlHeap *self, int nodeIndex)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_heap_up</name>
      <anchorfile>heap_8c.html</anchorfile>
      <anchor>e6cc22a3d7c88e8be68838c22f0b6ed3</anchor>
      <arglist>(VlHeap *self, int nodeIndex)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_heap_push</name>
      <anchorfile>heap_8c.html</anchorfile>
      <anchor>dda790fe62994953922367eec7fdb720</anchor>
      <arglist>(VlHeap *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void *</type>
      <name>vl_heap_pop</name>
      <anchorfile>heap_8c.html</anchorfile>
      <anchor>cd4786a27cd2a6a7b6ba67e6c6ce3287</anchor>
      <arglist>(VlHeap *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_heap_update</name>
      <anchorfile>heap_8c.html</anchorfile>
      <anchor>bc23f1df50225e338e91a13db3ff1b54</anchor>
      <arglist>(VlHeap *self, int unsigned nodeIndex)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>heap.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>heap_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <class kind="struct">_VlHeap</class>
    <member kind="typedef">
      <type>struct _VlHeap</type>
      <name>VlHeap</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>a54ddd51c1d32bab98e62b5eab4596e2</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlHeap *</type>
      <name>vl_heap_new</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>bb47c19977bcd9dd7f651fee4095035c</anchor>
      <arglist>(void *nodes, int nodeSize, int(*compare)(void const *a, void const *b))</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_heap_delete</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>b5958212f5b6706188d37bf65d5dfa47</anchor>
      <arglist>(VlHeap *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int unsigned</type>
      <name>vl_heap_get_node_num</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>813a09424093b557c4d246f2d3909ec4</anchor>
      <arglist>(VlHeap *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void *</type>
      <name>vl_heap_get_node_with_index</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>a1faaf45ea015f620b4aa84fed2d8f69</anchor>
      <arglist>(VlHeap *self, int unsigned nodeIndex)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_heap_clear</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>f01b8c18585c9ad6ffaa652fca8e304a</anchor>
      <arglist>(VlHeap *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_heap_push</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>dda790fe62994953922367eec7fdb720</anchor>
      <arglist>(VlHeap *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void *</type>
      <name>vl_heap_pop</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>cd4786a27cd2a6a7b6ba67e6c6ce3287</anchor>
      <arglist>(VlHeap *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_heap_update</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>bc23f1df50225e338e91a13db3ff1b54</anchor>
      <arglist>(VlHeap *self, int unsigned nodeIndex)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_heap_set_swap_func</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>eb495a03dbc0be0030fe9663cdde3507</anchor>
      <arglist>(VlHeap *self, void(*swap)(void *custom, void *a, void *b), void *customData)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int unsigned</type>
      <name>vl_heap_parent</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>22a3bc69fa8ea7ba1209f781de1b67c6</anchor>
      <arglist>(int unsigned nodeIndex)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int unsigned</type>
      <name>vl_heap_left_child</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>b3ef36922b3b658e08f02fff33189529</anchor>
      <arglist>(int unsigned nodeIndex)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int unsigned</type>
      <name>vl_heap_right_child</name>
      <anchorfile>heap_8h.html</anchorfile>
      <anchor>722367068e9d850a77270ffb6f618f5f</anchor>
      <arglist>(int unsigned nodeIndex)</arglist>
    </member>
    <docanchor file="heap_8h">heap-overview</docanchor>
    <docanchor file="heap_8h">heap-tech</docanchor>
  </compound>
  <compound kind="file">
    <name>hikmeans.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>hikmeans_8c</filename>
    <includes id="hikmeans_8h" name="hikmeans.h" local="yes" imported="no">hikmeans.h</includes>
    <member kind="function">
      <type>vl_uint8 *</type>
      <name>vl_hikm_copy_subset</name>
      <anchorfile>hikmeans_8c.html</anchorfile>
      <anchor>384ec7365aceacc91f4fcbc2f672ca33</anchor>
      <arglist>(vl_uint8 const *data, vl_uint *ids, int N, int M, vl_uint id, int *N2)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static VlHIKMNode *</type>
      <name>xmeans</name>
      <anchorfile>hikmeans_8c.html</anchorfile>
      <anchor>cf737df5c4f527b87055348cb14e562b</anchor>
      <arglist>(VlHIKMTree *tree, vl_uint8 const *data, int N, int K, int height)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>xdelete</name>
      <anchorfile>hikmeans_8c.html</anchorfile>
      <anchor>adddad0081d1f54bbb0a198ed4f16916</anchor>
      <arglist>(VlHIKMNode *node)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlHIKMTree *</type>
      <name>vl_hikm_new</name>
      <anchorfile>hikmeans_8c.html</anchorfile>
      <anchor>3df622c52440e12947fcc42756253262</anchor>
      <arglist>(int method)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_hikm_delete</name>
      <anchorfile>hikmeans_8c.html</anchorfile>
      <anchor>c326f6779f5420a6eb259d8a39cec0ff</anchor>
      <arglist>(VlHIKMTree *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_hikm_init</name>
      <anchorfile>hikmeans_8c.html</anchorfile>
      <anchor>ca0744616b320a46069476ec30382ee6</anchor>
      <arglist>(VlHIKMTree *f, int M, int K, int depth)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_hikm_train</name>
      <anchorfile>hikmeans_8c.html</anchorfile>
      <anchor>454d540aa6f331b609530e06e1c51508</anchor>
      <arglist>(VlHIKMTree *f, vl_uint8 const *data, int N)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_hikm_push</name>
      <anchorfile>hikmeans_8c.html</anchorfile>
      <anchor>06d5d0eb74726a82e746e792e8f67f6b</anchor>
      <arglist>(VlHIKMTree *f, vl_uint *asgn, vl_uint8 const *data, int N)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>hikmeans.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>hikmeans_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <includes id="ikmeans_8h" name="ikmeans.h" local="yes" imported="no">ikmeans.h</includes>
    <class kind="struct">_VlHIKMNode</class>
    <class kind="struct">_VlHIKMTree</class>
    <member kind="typedef">
      <type>struct _VlHIKMNode</type>
      <name>VlHIKMNode</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>840c059149338e3a415fb4397811b08f</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct _VlHIKMTree</type>
      <name>VlHIKMTree</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>69669e04f374c37fa2ff86a520a9c4e1</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlHIKMTree *</type>
      <name>vl_hikm_new</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>3df622c52440e12947fcc42756253262</anchor>
      <arglist>(int method)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_hikm_delete</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>c326f6779f5420a6eb259d8a39cec0ff</anchor>
      <arglist>(VlHIKMTree *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_hikm_get_ndims</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>01fdc1ab6a5b73ec9901d9d18939c5e0</anchor>
      <arglist>(VlHIKMTree const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_hikm_get_K</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>03acfb4bb1825ec9d3e080691aef5f84</anchor>
      <arglist>(VlHIKMTree const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_hikm_get_depth</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>fdebb75f6c0bd462d914775abc8903d5</anchor>
      <arglist>(VlHIKMTree const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_hikm_get_verbosity</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>5e38b3f85a715acc699af79aab396e1f</anchor>
      <arglist>(VlHIKMTree const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_hikm_get_max_niters</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>324d5d0171e6da2673f8a7b620f2915e</anchor>
      <arglist>(VlHIKMTree const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE VlHIKMNode const *</type>
      <name>vl_hikm_get_root</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>1b274b4dc0e9e7b27c315544c05280a5</anchor>
      <arglist>(VlHIKMTree const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_hikm_set_verbosity</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>7361c1051678b07c45c052a39550cea4</anchor>
      <arglist>(VlHIKMTree *f, int verb)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_hikm_set_max_niters</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>6f5f5721b1e608d4fe941470ebece4aa</anchor>
      <arglist>(VlHIKMTree *f, int max_niters)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_hikm_init</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>ca0744616b320a46069476ec30382ee6</anchor>
      <arglist>(VlHIKMTree *f, int M, int K, int depth)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_hikm_train</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>454d540aa6f331b609530e06e1c51508</anchor>
      <arglist>(VlHIKMTree *f, vl_uint8 const *data, int N)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_hikm_push</name>
      <anchorfile>hikmeans_8h.html</anchorfile>
      <anchor>06d5d0eb74726a82e746e792e8f67f6b</anchor>
      <arglist>(VlHIKMTree *f, vl_uint *asgn, vl_uint8 const *data, int N)</arglist>
    </member>
    <docanchor file="hikmeans_8h">hikm-tree</docanchor>
  </compound>
  <compound kind="file">
    <name>host.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>host_8c</filename>
    <includes id="host_8h" name="host.h" local="yes" imported="no">host.h</includes>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <member kind="define">
      <type>#define</type>
      <name>HAS_CPUID</name>
      <anchorfile>host_8c.html</anchorfile>
      <anchor>64a428a197a6f71e42806354612841ef</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>vl_set_simd_enabled</name>
      <anchorfile>host_8c.html</anchorfile>
      <anchor>3fb6cee731450d886e49da54e29788e8</anchor>
      <arglist>(vl_bool x)</arglist>
    </member>
    <member kind="function">
      <type>vl_bool</type>
      <name>vl_get_simd_enabled</name>
      <anchorfile>host_8c.html</anchorfile>
      <anchor>8fd5c5f53a678b8e24505f1fc98490a2</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>vl_bool</type>
      <name>vl_cpu_has_sse3</name>
      <anchorfile>host_8c.html</anchorfile>
      <anchor>d176e5e370a9fbe9cb1995f53d228c0f</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>vl_bool</type>
      <name>vl_cpu_has_sse2</name>
      <anchorfile>host_8c.html</anchorfile>
      <anchor>8b42bd1be913fee5ae234899bbd5990d</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>vl_print_host_info</name>
      <anchorfile>host_8c.html</anchorfile>
      <anchor>a09e40d6b2d94bac530b7949962a7c51</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="variable">
      <type>vl_bool</type>
      <name>simd_enabled</name>
      <anchorfile>host_8c.html</anchorfile>
      <anchor>32f765c1092ce1484ef1124022404ecb</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>host.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>host_8h</filename>
    <member kind="define">
      <type>#define</type>
      <name>VL_OS_LINUX</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>ce5a6e77fa663303cfd489f3eaaf1cd9</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_OS_MACOSX</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>6368203ab40afc45aa5d2faaf794038e</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_OS_WIN</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>9e8b6b892c4c517efb458a908f8d8f89</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_OS_WIN64</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>5a08df472ecc78e67b920ca29217fabf</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_COMPILER_GNUC</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>1d501d055fcbcd42c1369c64f4bc8e8d</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_COMPILER_MSC</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>27371f6fc56a871d3d2a2dea1b191cbf</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_COMPILER_LCC</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>8c241c8e1d46fc25653460876004fbee</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_ARCH_IX86</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>ad2a5cd35841264fc165f9b92fad3feb</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_ARCH_IA64</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>55960eea1c39d0ed79519e4fbdb782bf</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_COMPILER_LLP64</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>01af69f0de0af937ca06729348d3b1a6</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_COMPILER_LP64</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>06056894ccd483c6171eec205fb253a6</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_COMPILER_ILP32</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>426f6e574a76d69692eace4d858b9adf</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_ARCH_LITTLE_ENDIAN</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>2f05e20e356b146f3d111f403657ca17</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_ARCH_BIG_ENDIAN</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>040b85d2764e6270f5d14515c8ab02aa</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_FL_INT64</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>9e0dd28d4000da64e451fbce6939cb6f</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_FL_INT32</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>c08de2d648945a77801c9884a0ff752d</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_FL_INT16</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>065ee814c68df328e58181c387f8ccf6</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_FL_INT8</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>782a8eb010de36cbc9c4517f73c23d29</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_BIG_INT</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>2a2754158f58ad8118579b45f66426f3</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_SMALL_INT</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>b11084ae11b83378e74bf4b1e545f134</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_BIG_UINT</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>985a5b1b02b23f20c72ba5d5b9abab2d</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_set_simd_enabled</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>a078c7731fa1d2aab914d13bec0b5c39</anchor>
      <arglist>(vl_bool x)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT vl_bool</type>
      <name>vl_get_simd_enabled</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>ef6408c279628666a04fb82205c942bd</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_swap_host_big_endianness_8</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>06b8ad01a424679c640ed1a296bffb30</anchor>
      <arglist>(void *dst, void *src)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_swap_host_big_endianness_4</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>124102058469b65d02a789c6131a56df</anchor>
      <arglist>(void *dst, void *src)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_swap_host_big_endianness_2</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>36975e12ab72a5db22e15e8b93ff4a89</anchor>
      <arglist>(void *dst, void *src)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_print_host_info</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>e1ce13976ce3aad95b7b4f657b8f1766</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT vl_bool</type>
      <name>vl_cpu_has_sse3</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>c95bf6bcef667aaaef2f1aedcf51c334</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT vl_bool</type>
      <name>vl_cpu_has_sse2</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>dd6ff12af3078afcf5014c0eae62e60b</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_TRUE</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>0c72a8c7d2abcd2871b3348138c5f1f4</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_FALSE</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>bce143a5a9b51d987a74f2ad30046520</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>long long</type>
      <name>vl_int64</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>b9925d4a6df873da6df7a59d2a97d81c</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>int</type>
      <name>vl_int32</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>03fa435c713d3141c4a700f79f5b2600</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>short</type>
      <name>vl_int16</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>47e046602e64d54280961328bf950ca1</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>char</type>
      <name>vl_int8</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>ee4cc9690b799a33dfc9614636ac34a1</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>long long unsigned</type>
      <name>vl_uint64</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>f37832522d1f5c028ac15d0ccda7ff48</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>int unsigned</type>
      <name>vl_uint32</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>eb7c862765448a70017105efa4d25e7a</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>short unsigned</type>
      <name>vl_uint16</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>b2275d6c7bf6fc027151d11072b45f03</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>char unsigned</type>
      <name>vl_uint8</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>38fbd9a3cf53dfc9a5650c38497b7d35</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>int</type>
      <name>vl_int</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>8127af01f6220099c1dd4ec579f5ae09</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>unsigned int</type>
      <name>vl_uint</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>5bd6e91d6bfd0be04101fdca94069c92</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>int</type>
      <name>vl_bool</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>d32e7f8ec7333ff33998cf671a3b1412</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>vl_int64</type>
      <name>vl_intptr</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>fa16bd9b637357fb5590b7154987239b</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>vl_uint64</type>
      <name>vl_uintptr</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>20819052598008f96d3bd302a35c9d59</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>vl_uint64</type>
      <name>vl_size</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>0ee26101458c663510d620e3ee7e2555</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>vl_int64</type>
      <name>vl_index</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>66417c5847876295ea87b38140073879</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>vl_uint64</type>
      <name>vl_uindex</name>
      <anchorfile>host_8h.html</anchorfile>
      <anchor>c13bd3cc913e1da576e189a3ec8d66fc</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="host_8h">host-arch-endianness</docanchor>
    <docanchor file="host_8h">host-os</docanchor>
    <docanchor file="host_8h">host-compiler</docanchor>
    <docanchor file="host_8h">host-arch</docanchor>
    <docanchor file="host_8h">host-compiler-data-model</docanchor>
    <docanchor file="host_8h">host-compiler-other</docanchor>
  </compound>
  <compound kind="file">
    <name>ikmeans.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>ikmeans_8c</filename>
    <includes id="ikmeans_8h" name="ikmeans.h" local="yes" imported="no">ikmeans.h</includes>
    <includes id="ikmeans__init_8tc" name="ikmeans_init.tc" local="yes" imported="no">ikmeans_init.tc</includes>
    <includes id="ikmeans__lloyd_8tc" name="ikmeans_lloyd.tc" local="yes" imported="no">ikmeans_lloyd.tc</includes>
    <includes id="ikmeans__elkan_8tc" name="ikmeans_elkan.tc" local="yes" imported="no">ikmeans_elkan.tc</includes>
    <member kind="function">
      <type>VlIKMFilt *</type>
      <name>vl_ikm_new</name>
      <anchorfile>ikmeans_8c.html</anchorfile>
      <anchor>f5a42441a336dd73c39c5a1ec8028444</anchor>
      <arglist>(int method)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>vl_ikm_delete</name>
      <anchorfile>ikmeans_8c.html</anchorfile>
      <anchor>33a659152e03286d390aa17b1a212a7b</anchor>
      <arglist>(VlIKMFilt *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_ikm_train</name>
      <anchorfile>ikmeans_8c.html</anchorfile>
      <anchor>ef1d478194258cdd7ac94bcf8c610518</anchor>
      <arglist>(VlIKMFilt *f, vl_uint8 const *data, int N)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_ikm_push</name>
      <anchorfile>ikmeans_8c.html</anchorfile>
      <anchor>3925a371d89bf4d5d73d49d4c78c15ea</anchor>
      <arglist>(VlIKMFilt *f, vl_uint *asgn, vl_uint8 const *data, int N)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT vl_uint</type>
      <name>vl_ikm_push_one</name>
      <anchorfile>ikmeans_8c.html</anchorfile>
      <anchor>531ffc23996b86a8ed520251e40c7663</anchor>
      <arglist>(vl_ikm_acc const *centers, vl_uint8 const *data, int M, int K)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>ikmeans.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>ikmeans_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <class kind="struct">_VlIKMFilt</class>
    <member kind="typedef">
      <type>vl_int32</type>
      <name>vl_ikm_acc</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>205ce6418452915b7ac046e10db82a50</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct _VlIKMFilt</type>
      <name>VlIKMFilt</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>e310add6663ca6c9c8a2075549d26cfc</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>VlIKMAlgorithms</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>4aa95067e495fa8309ab028307a3418d</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>VL_IKM_LLOYD</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>4aa95067e495fa8309ab028307a3418d03abd693c3d932bb543401274eb868c4</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>VL_IKM_ELKAN</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>4aa95067e495fa8309ab028307a3418d46d6e04c3599a881c16722b6969c5a21</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlIKMFilt *</type>
      <name>vl_ikm_new</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>327d10e35e5b150b6b77a2645dd724b7</anchor>
      <arglist>(int method)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_ikm_delete</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>3a659ff1d3126dbf4082a19a11077c37</anchor>
      <arglist>(VlIKMFilt *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_ikm_init</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>5384081d9c0b7afc7095c3e00c3552f2</anchor>
      <arglist>(VlIKMFilt *f, vl_ikm_acc const *centers, int M, int K)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_ikm_init_rand</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>4905cc4d70c541087287b47029c28a61</anchor>
      <arglist>(VlIKMFilt *f, int M, int K)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_ikm_init_rand_data</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>d83be68d9faeb99e8e1e99cea32ab11b</anchor>
      <arglist>(VlIKMFilt *f, vl_uint8 const *data, int M, int N, int K)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_ikm_train</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>ef1d478194258cdd7ac94bcf8c610518</anchor>
      <arglist>(VlIKMFilt *f, vl_uint8 const *data, int N)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_ikm_push</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>3925a371d89bf4d5d73d49d4c78c15ea</anchor>
      <arglist>(VlIKMFilt *f, vl_uint *asgn, vl_uint8 const *data, int N)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT vl_uint</type>
      <name>vl_ikm_push_one</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>531ffc23996b86a8ed520251e40c7663</anchor>
      <arglist>(vl_ikm_acc const *centers, vl_uint8 const *data, int M, int K)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_ikm_get_ndims</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>4280079096cde40f1e5d7c4107c47298</anchor>
      <arglist>(VlIKMFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_ikm_get_K</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>08a156843aac7e01c80d920b6855b2a7</anchor>
      <arglist>(VlIKMFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_ikm_get_verbosity</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>df87090839a1caeef887d70b68f778bd</anchor>
      <arglist>(VlIKMFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_ikm_get_max_niters</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>4eca24c1ddd42e00ed32a75bb0f3b535</anchor>
      <arglist>(VlIKMFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_ikm_acc const *</type>
      <name>vl_ikm_get_centers</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>947d6a83e612fe6a39874468094d9b52</anchor>
      <arglist>(VlIKMFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_ikm_set_verbosity</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>472299c9e390c95ab5ab0a07bf7b8822</anchor>
      <arglist>(VlIKMFilt *f, int verb)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_ikm_set_max_niters</name>
      <anchorfile>ikmeans_8h.html</anchorfile>
      <anchor>f7e25decb329f871371811e2f9c2ebea</anchor>
      <arglist>(VlIKMFilt *f, int max_niters)</arglist>
    </member>
    <docanchor file="ikmeans_8h">ikmeans-alg-lloyd</docanchor>
    <docanchor file="ikmeans_8h">ikmeans-alg-init</docanchor>
    <docanchor file="ikmeans_8h">ikmeans-algo</docanchor>
    <docanchor file="ikmeans_8h">ikmeans-alg-elkan</docanchor>
  </compound>
  <compound kind="file">
    <name>ikmeans_elkan.tc</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>ikmeans__elkan_8tc</filename>
    <member kind="function" static="yes">
      <type>static unsigned int</type>
      <name>isqrt</name>
      <anchorfile>ikmeans__elkan_8tc.html</anchorfile>
      <anchor>c268af957fa36837c732efe06702783a</anchor>
      <arglist>(unsigned long val)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>vl_ikm_elkan_update_inter_dist</name>
      <anchorfile>ikmeans__elkan_8tc.html</anchorfile>
      <anchor>7664bd055d36da01663d01fd5d50da60</anchor>
      <arglist>(VlIKMFilt *f)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>vl_ikm_init_elkan</name>
      <anchorfile>ikmeans__elkan_8tc.html</anchorfile>
      <anchor>ee753adccae45559ab12120905e2ed57</anchor>
      <arglist>(VlIKMFilt *f)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>vl_ikm_train_elkan</name>
      <anchorfile>ikmeans__elkan_8tc.html</anchorfile>
      <anchor>4ef75811e5a94d30491eb1c2c63bcf1e</anchor>
      <arglist>(VlIKMFilt *f, vl_uint8 const *data, int N)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>vl_ikm_push_elkan</name>
      <anchorfile>ikmeans__elkan_8tc.html</anchorfile>
      <anchor>3ccd1662e818a9dc28de12ff4faaba12</anchor>
      <arglist>(VlIKMFilt *f, vl_uint *asgn, vl_uint8 const *data, int N)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>ikmeans_init.tc</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>ikmeans__init_8tc</filename>
    <includes id="random_8h" name="random.h" local="yes" imported="no">random.h</includes>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>alloc</name>
      <anchorfile>ikmeans__init_8tc.html</anchorfile>
      <anchor>3f1a524f016b97b3834125c97b34320b</anchor>
      <arglist>(VlIKMFilt *f, int M, int K)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>vl_ikm_init_helper</name>
      <anchorfile>ikmeans__init_8tc.html</anchorfile>
      <anchor>64bc8e2fb8307d6879c16ed78e3127e7</anchor>
      <arglist>(VlIKMFilt *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_ikm_init</name>
      <anchorfile>ikmeans__init_8tc.html</anchorfile>
      <anchor>5384081d9c0b7afc7095c3e00c3552f2</anchor>
      <arglist>(VlIKMFilt *f, vl_ikm_acc const *centers, int M, int K)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_ikm_init_rand</name>
      <anchorfile>ikmeans__init_8tc.html</anchorfile>
      <anchor>4905cc4d70c541087287b47029c28a61</anchor>
      <arglist>(VlIKMFilt *f, int M, int K)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_ikm_init_rand_data</name>
      <anchorfile>ikmeans__init_8tc.html</anchorfile>
      <anchor>d83be68d9faeb99e8e1e99cea32ab11b</anchor>
      <arglist>(VlIKMFilt *f, vl_uint8 const *data, int M, int N, int K)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>ikmeans_lloyd.tc</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>ikmeans__lloyd_8tc</filename>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>vl_ikm_init_lloyd</name>
      <anchorfile>ikmeans__lloyd_8tc.html</anchorfile>
      <anchor>953ada58fb717a7a37883f05ee1859c5</anchor>
      <arglist>(VlIKMFilt *f)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>vl_ikm_train_lloyd</name>
      <anchorfile>ikmeans__lloyd_8tc.html</anchorfile>
      <anchor>ed710bab56c0085ab200f462a7ab275f</anchor>
      <arglist>(VlIKMFilt *f, vl_uint8 const *data, int N)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>vl_ikm_push_lloyd</name>
      <anchorfile>ikmeans__lloyd_8tc.html</anchorfile>
      <anchor>fb21433b50d73f3468ce0e0cbc09fd42</anchor>
      <arglist>(VlIKMFilt *f, vl_uint *asgn, vl_uint8 const *data, int N)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>imop.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>imop_8c</filename>
    <includes id="imop_8h" name="imop.h" local="yes" imported="no">imop.h</includes>
    <includes id="imop_8tc" name="imop.tc" local="yes" imported="no">imop.tc</includes>
    <member kind="define">
      <type>#define</type>
      <name>PIX</name>
      <anchorfile>imop_8c.html</anchorfile>
      <anchor>fd9ef7593a25ffad52e92b49462bdc7e</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>FLT</name>
      <anchorfile>imop_8c.html</anchorfile>
      <anchor>96483ebc24570d6aae64344a594463b6</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>SFX</name>
      <anchorfile>imop_8c.html</anchorfile>
      <anchor>52e87f85ae30be82ffefd31b5c03e03d</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>imop.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>imop_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <member kind="define">
      <type>#define</type>
      <name>VL_CONV_ZERO</name>
      <anchorfile>imop_8h.html</anchorfile>
      <anchor>3f1306e516642e53257e5bde69b02d01</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_CONV_CIRC</name>
      <anchorfile>imop_8h.html</anchorfile>
      <anchor>824b21411f9c73f6baa296027ee1bc8b</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_CONV_CONT</name>
      <anchorfile>imop_8h.html</anchorfile>
      <anchor>cc763fedf2b869090ddebe38be337e77</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_convtransp_f</name>
      <anchorfile>imop_8h.html</anchorfile>
      <anchor>a67ba48286079c71886bd57acf35b651</anchor>
      <arglist>(float *dst, float const *src, float const *filt, int width, int height, int filt_width, int mode)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_convtransp_d</name>
      <anchorfile>imop_8h.html</anchorfile>
      <anchor>152c8365f133eb2ac64f3d7de1bc8c73</anchor>
      <arglist>(double *dst, double const *src, double const *filt, int width, int height, int filt_width, int mode)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_imsmooth_f</name>
      <anchorfile>imop_8h.html</anchorfile>
      <anchor>1a4f88af24e32dea5e6a84cf3c7590d8</anchor>
      <arglist>(float *dst, float *temp, float const *src, int width, int height, double sigma)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_imsmooth_d</name>
      <anchorfile>imop_8h.html</anchorfile>
      <anchor>f784de5de465c3a65c21c9a1c1f71466</anchor>
      <arglist>(double *dst, double *temp, double const *src, int width, int height, double sigma)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>imop.tc</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>imop_8tc</filename>
    <includes id="mathop_8h" name="mathop.h" local="yes" imported="no">mathop.h</includes>
  </compound>
  <compound kind="file">
    <name>imopv.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>imopv_8c</filename>
    <includes id="imopv_8h" name="imopv.h" local="yes" imported="no">imopv.h</includes>
    <includes id="imopv__sse2_8h" name="imopv_sse2.h" local="yes" imported="no">imopv_sse2.h</includes>
    <includes id="imopv_8tc" name="imopv.tc" local="yes" imported="no">imopv.tc</includes>
  </compound>
  <compound kind="file">
    <name>imopv.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>imopv_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <member kind="define">
      <type>#define</type>
      <name>VL_PAD_BY_ZERO</name>
      <anchorfile>imopv_8h.html</anchorfile>
      <anchor>f6e169f2ed366d16f9149a99d5574071</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_PAD_BY_CONTINUITY</name>
      <anchorfile>imopv_8h.html</anchorfile>
      <anchor>abcdd51c289c0d8db11dda9e26349a52</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_PAD_MASK</name>
      <anchorfile>imopv_8h.html</anchorfile>
      <anchor>2a4f0c469409eea71985bac3f10d08fb</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_TRANSPOSE</name>
      <anchorfile>imopv_8h.html</anchorfile>
      <anchor>2489ff30a8c5d4048038a90b640a038a</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_imconvcol_vf</name>
      <anchorfile>imopv_8h.html</anchorfile>
      <anchor>032ec58dd2542db69351e006fbac1b13</anchor>
      <arglist>(float *dst, int dst_stride, float const *src, int src_width, int src_height, int src_stride, float const *filt, int filt_begin, int filt_end, int step, unsigned int flags)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_imconvcol_vd</name>
      <anchorfile>imopv_8h.html</anchorfile>
      <anchor>165f552920957a65884b0937034e4c9a</anchor>
      <arglist>(double *dst, int dst_stride, double const *src, int src_width, int src_height, int src_stride, double const *filt, int filt_begin, int filt_end, int step, unsigned int flags)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_imconvcoltri_vf</name>
      <anchorfile>imopv_8h.html</anchorfile>
      <anchor>4e9d44a40850d2a6f2930065d1dc3922</anchor>
      <arglist>(float *dst, int dst_stride, float const *src, int src_width, int src_height, int src_stride, int filt_size, int step, unsigned int flags)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_imconvcoltri_vd</name>
      <anchorfile>imopv_8h.html</anchorfile>
      <anchor>2d2d36a7959ba868ecd8f09cd0a9dc52</anchor>
      <arglist>(double *dst, int dst_stride, double const *src, int src_width, int src_height, int src_stride, int filt_size, int step, unsigned int flags)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>imopv.tc</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>imopv_8tc</filename>
  </compound>
  <compound kind="file">
    <name>imopv_sse2.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>imopv__sse2_8c</filename>
  </compound>
  <compound kind="file">
    <name>imopv_sse2.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>imopv__sse2_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
  </compound>
  <compound kind="file">
    <name>kdtree.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>kdtree_8c</filename>
    <includes id="kdtree_8h" name="kdtree.h" local="yes" imported="no">kdtree.h</includes>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <includes id="random_8h" name="random.h" local="yes" imported="no">random.h</includes>
    <includes id="mathop_8h" name="mathop.h" local="yes" imported="no">mathop.h</includes>
    <member kind="function">
      <type>int unsigned</type>
      <name>vl_kdtree_node_new</name>
      <anchorfile>kdtree_8c.html</anchorfile>
      <anchor>0f8bcfc1860957b70cdbcbf6e03e0425</anchor>
      <arglist>(VlKDTree *tree, int unsigned parentIndex)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>vl_kdtree_compare_index_entries</name>
      <anchorfile>kdtree_8c.html</anchorfile>
      <anchor>9de65262a119712c22e68fbfca3d02ac</anchor>
      <arglist>(void const *a, void const *b)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>vl_kdtree_build_recursively</name>
      <anchorfile>kdtree_8c.html</anchorfile>
      <anchor>e7b96fbb8190854a8fef25e7e4d82bc0</anchor>
      <arglist>(VlKDForest *forest, VlKDTree *tree, unsigned int nodeIndex, unsigned int dataBegin, unsigned int dataEnd, unsigned int depth)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlKDForest *</type>
      <name>vl_kdforest_new</name>
      <anchorfile>kdtree_8c.html</anchorfile>
      <anchor>0a94ee1ef061e4c51305bc0a3cf948af</anchor>
      <arglist>(int unsigned numDimensions, int unsigned numTrees)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_kdforest_delete</name>
      <anchorfile>kdtree_8c.html</anchorfile>
      <anchor>f2e093f010ccc6db5e8d19f6a7b31684</anchor>
      <arglist>(VlKDForest *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_kdforest_build</name>
      <anchorfile>kdtree_8c.html</anchorfile>
      <anchor>eaa0ff64d65550d41615464efd4098d8</anchor>
      <arglist>(VlKDForest *self, int numData, float const *data)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE float</type>
      <name>calc_dist2</name>
      <anchorfile>kdtree_8c.html</anchorfile>
      <anchor>d3efeee6f8198f0c3bd345afebe9b894</anchor>
      <arglist>(float const *a, float const *b, int unsigned N)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_kdforest_query_recursively</name>
      <anchorfile>kdtree_8c.html</anchorfile>
      <anchor>cff94747d3068233115a58655f2e3f5c</anchor>
      <arglist>(VlKDForest *self, VlKDTree *tree, int unsigned nodeIndex, VlKDForestNeighbor *neighbors, int unsigned numNeighbors, int unsigned *numAddedNeighbors, float dist, float const *query)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>vl_kdtree_calc_bounds_recursively</name>
      <anchorfile>kdtree_8c.html</anchorfile>
      <anchor>b35f55ad5a3dc909a5d7a4f0795dc7a4</anchor>
      <arglist>(VlKDTree *tree, int unsigned nodeIndex, float *searchBounds)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_kdforest_query</name>
      <anchorfile>kdtree_8c.html</anchorfile>
      <anchor>977a93b67b3358bb20c5f5c169350184</anchor>
      <arglist>(VlKDForest *self, VlKDForestNeighbor *neighbors, int unsigned numNeighbors, float const *query)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>kdtree.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>kdtree_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <class kind="struct">_VlKDForestNeighbor</class>
    <class kind="struct">_VlKDForest</class>
    <member kind="typedef">
      <type>enum _VlKDTreeThresholdingMethod</type>
      <name>VlKDTreeThresholdingMethod</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>9af55b2fcdfed500314205a3449b37d4</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct _VlKDForestNeighbor</type>
      <name>VlKDForestNeighbor</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>7f6df51074aefc44e6e0295beaea03b4</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct _VlKDForest</type>
      <name>VlKDForest</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>f2305db9740ef5501b5e6a19a374a726</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>_VlKDTreeThresholdingMethod</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>f178ae6c1876c146ba00155d5c16c531</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlKDForest *</type>
      <name>vl_kdforest_new</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>0a94ee1ef061e4c51305bc0a3cf948af</anchor>
      <arglist>(int unsigned numDimensions, int unsigned numTrees)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_kdforest_delete</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>f2e093f010ccc6db5e8d19f6a7b31684</anchor>
      <arglist>(VlKDForest *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_kdforest_build</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>eaa0ff64d65550d41615464efd4098d8</anchor>
      <arglist>(VlKDForest *self, int numData, float const *data)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_kdforest_query</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>977a93b67b3358bb20c5f5c169350184</anchor>
      <arglist>(VlKDForest *self, VlKDForestNeighbor *neighbors, int unsigned numNeighbors, float const *query)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int unsigned</type>
      <name>vl_kdforest_get_depth_of_tree</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>8fb970ae49883f62c41dcff394f8a09f</anchor>
      <arglist>(VlKDForest const *self, int unsigned treeIndex)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int unsigned</type>
      <name>vl_kdforest_get_num_nodes_of_tree</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>82505240c5c9e336fb159bb3de5e09eb</anchor>
      <arglist>(VlKDForest const *self, int unsigned treeIndex)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int unsigned</type>
      <name>vl_kdforest_get_num_trees</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>2a61401c5b65f13c2b93c506baaf2d7d</anchor>
      <arglist>(VlKDForest const *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_kdforest_set_max_num_comparisons</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>7339e1c40b53ebef1486a8b2b574168a</anchor>
      <arglist>(VlKDForest *self, int unsigned n)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int unsigned</type>
      <name>vl_kdforest_get_max_num_comparisons</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>170cfbe5e44c511db20694c567449612</anchor>
      <arglist>(VlKDForest *self)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_kdforest_set_thresholding_method</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>170103952f5fa62bd7577363b9273272</anchor>
      <arglist>(VlKDForest *self, VlKDTreeThresholdingMethod method)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE VlKDTreeThresholdingMethod</type>
      <name>vl_kdforest_get_thresholding_method</name>
      <anchorfile>kdtree_8h.html</anchorfile>
      <anchor>83eeaa0e8299d79ca7c182fd19d8ba3c</anchor>
      <arglist>(VlKDForest const *self)</arglist>
    </member>
    <docanchor file="kdtree_8h">kdtree-tech</docanchor>
    <docanchor file="kdtree_8h">kdtree-references</docanchor>
    <docanchor file="kdtree_8h">kdtree-overview</docanchor>
  </compound>
  <compound kind="file">
    <name>mathop.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>mathop_8c</filename>
    <includes id="mathop_8h" name="mathop.h" local="yes" imported="no">mathop.h</includes>
  </compound>
  <compound kind="file">
    <name>mathop.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>mathop_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <member kind="define">
      <type>#define</type>
      <name>VL_LOG_OF_2</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>5103e2bf416806fb511feaa8ee96328f</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_PI</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>19d43a5e0c355df553ebe825208a4cc1</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_EPSILON_F</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>8088f3da04d6bce27544adaa6da948ca</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_EPSILON_D</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>a2d957b08ce16011fc3827c270cd2664</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_NAN_F</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>fcbfd66dfa72bf495e08e1d622d6da0e</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_INFINITY_F</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>7c8e51b4132fa5072a31ec38770e22c6</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_NAN_D</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>3f9df65fc71880e96e21e93e3abfd99c</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_INFINITY_D</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>9eb876cf62894be62a2467db9db0bb03</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>enum _VlVectorComparisonType</type>
      <name>VlVectorComparisonType</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>a4cc7d511f708d61bc8fe15c65ad6d74</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>_VlVectorComparisonType</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>f7397bb42d71000754eafba9458b09ac</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>VlDistanceL1</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>f7397bb42d71000754eafba9458b09acff42f6aa9da4f0d11415de32089a1348</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>VlDistanceL2</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>f7397bb42d71000754eafba9458b09acb44b9322465d703274acfa21690de9fd</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>VlDistanceChi2</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>f7397bb42d71000754eafba9458b09ac8bd37a4dd18960b8faf2c52093227857</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>VlKernelL1</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>f7397bb42d71000754eafba9458b09ac5e26182d2d853d6e16238535fd8f7f98</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>VlKernelL2</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>f7397bb42d71000754eafba9458b09acad5fb6e24379dd36f94bdfb10068ec6c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>VlKernelChi2</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>f7397bb42d71000754eafba9458b09acd945961afcae876365e585655b3dbdde</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>ui16</type>
      <name>VL_FAST_SQRT_UI</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>0f45d87cc1746cfc85bc23bb14f7c45e</anchor>
      <arglist>(vl_uint8, ui8) typedef float(*VlFloatVectorComparisonFunction)(vl_size dimension</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE float</type>
      <name>vl_mod_2pi_f</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>779371154b6f6c1a0f9bf51ad9afcd07</anchor>
      <arglist>(float x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_mod_2pi_d</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>b3a92ebb19b74de0f5853016c70fe7b0</anchor>
      <arglist>(double x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_floor_f</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>0a641bb83f3aa7db107a51f63a534b52</anchor>
      <arglist>(float x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_floor_d</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>48bb7ee0a0b8f26c1ddcc8e9821f36ac</anchor>
      <arglist>(double x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE float</type>
      <name>vl_abs_f</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>c661df89e4bbb2730b3b5a8d15713084</anchor>
      <arglist>(float x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_abs_d</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>b54b15a314843c27e7333e2fd05c0eb8</anchor>
      <arglist>(double x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE float</type>
      <name>vl_fast_atan2_f</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>83b506c15839a1b6b07ed81e20f2906e</anchor>
      <arglist>(float y, float x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_fast_atan2_d</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>78e511bf11055a29ef1d3fb9c1b74335</anchor>
      <arglist>(double y, double x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE float</type>
      <name>vl_fast_resqrt_f</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>d9c702db6c4e7f2fc20d8e2f4b989032</anchor>
      <arglist>(float x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_fast_resqrt_d</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>12d10d044fd75e618b83d4c390071e78</anchor>
      <arglist>(double x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE float</type>
      <name>vl_fast_sqrt_f</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>fd17414c0bd6edce9280378201a24847</anchor>
      <arglist>(float x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_fast_sqrt_d</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>70b8ce69987f6aff1228f929ddf9ad26</anchor>
      <arglist>(float x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_uint32</type>
      <name>vl_fast_sqrt_ui32</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>39094d72320eff7aa86f69317732e3cc</anchor>
      <arglist>(vl_uint32 x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_uint16</type>
      <name>vl_fast_sqrt_ui16</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>43c9d07619e842e4e6804a7fc16c2b01</anchor>
      <arglist>(vl_uint16 x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_uint8</type>
      <name>vl_fast_sqrt_ui8</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>5a6bc29fcc3ac5a673d7d4c5191cf104</anchor>
      <arglist>(vl_uint8 x)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_eval_vector_comparison_on_all_pairs_f</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>e38ee42a415c7958c38c02ea57cf9b4e</anchor>
      <arglist>(float *result, vl_size dimension, float const *X, vl_size numDataX, float const *Y, vl_size numDataY, VlFloatVectorComparisonFunction function)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_eval_vector_comparison_on_all_pairs_d</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>b43cec2331656bbe580066b6406e100a</anchor>
      <arglist>(double *result, vl_size dimension, double const *X, vl_size numDataX, double const *Y, vl_size numDataY, VlDoubleVectorComparisonFunction)</arglist>
    </member>
    <member kind="variable" static="yes">
      <type>static union @0</type>
      <name>vl_nan_f</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>d2df0b72d0a88f90313ad71228123bd0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable" static="yes">
      <type>static union @1</type>
      <name>vl_infinity_f</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>dabaf3f06f47fc1d311fefd6ed2d42a8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable" static="yes">
      <type>static union @2</type>
      <name>vl_nan_d</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>5278a8052516f37178d1f0197e20aeac</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable" static="yes">
      <type>static union @3</type>
      <name>vl_infinity_d</name>
      <anchorfile>mathop_8h.html</anchorfile>
      <anchor>d9319193bef7533c4eb35e44b474c4f6</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>mathop.tc</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>mathop_8tc</filename>
  </compound>
  <compound kind="file">
    <name>mexutils.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/toolbox/</path>
    <filename>mexutils_8h</filename>
    <includes id="generic_8h" name="generic.h" local="no" imported="no">vl/generic.h</includes>
    <class kind="struct">_uMexOption</class>
    <member kind="define">
      <type>#define</type>
      <name>VL_USE_MATLAB_ENV</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>76600f902337bf06037c62b27d76255c</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VLMX_EIA</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>b7e283531a67ed9470973d8994a9e02c</anchor>
      <arglist>(...)</arglist>
    </member>
    <member kind="typedef">
      <type>struct _uMexOption</type>
      <name>uMexOption</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>8a343d594738b6672b4f5ad73d07eb8f</anchor>
      <arglist></arglist>
    </member>
    <member kind="function" static="yes">
      <type>static mxArray *</type>
      <name>uCreateNumericArray</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>cb6b7babe2d72a70fd87f45c25b92b03</anchor>
      <arglist>(mwSize ndim, const mwSize *dims, mxClassID classid, void *data)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static mxArray *</type>
      <name>uCreateNumericMatrix</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>5ce253e48f58f2b79172695537c62402</anchor>
      <arglist>(int M, int N, mxClassID classid, void *data)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static mxArray *</type>
      <name>uCreateScalar</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>237a04e511208177f7c00e11e5184b31</anchor>
      <arglist>(double x)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>uIsScalar</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>1c8c9615dfb27e6b8de0d79a6fdfa1f7</anchor>
      <arglist>(const mxArray *A)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static vl_bool</type>
      <name>uIsPlainArray</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>a7d0db8905768dae70a5cfb3e3fcdb59</anchor>
      <arglist>(const mxArray *A)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>uIsMatrix</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>1b15752ea101ba3abaaf8860aae8978b</anchor>
      <arglist>(const mxArray *A, int M, int N)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>uIsVector</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>29e5ca434a7aaf49de15457cc40f296e</anchor>
      <arglist>(const mxArray *A, int N)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>uIsReal</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>b962450cc2d0bb82e4824ad061f51f80</anchor>
      <arglist>(const mxArray *A)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>uIsRealScalar</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>a5e2b872c0cf270b64cf78ca0aa3c1b5</anchor>
      <arglist>(const mxArray *A)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>uIsRealMatrix</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>c161d6212ab83e1fa97be90de8f9cb82</anchor>
      <arglist>(const mxArray *A, int M, int N)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>uIsRealVector</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>252efe5f96c0f1d3c4d29716039851a1</anchor>
      <arglist>(const mxArray *A, int N)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>uIsRealArray</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>86aeba58a0b843f89c1a0e987069b0f5</anchor>
      <arglist>(const mxArray *A, int D, int *dims)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>uIsString</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>8b13f96d5a5470804c4d94b60e07c549</anchor>
      <arglist>(const mxArray *A, int L)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>mxuError</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>9094a2722cadf5c94a1496c504aa1f2a</anchor>
      <arglist>(char const *errorId, char const *errorMessage,...)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>uErrMsgTxt</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>6d797424f307e26d48f08b9534fb442d</anchor>
      <arglist>(char const *format,...)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>uStrICmp</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>eb8facc0f350d442ab1b183677f6acca</anchor>
      <arglist>(const char *s1, const char *s2)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>uNextOption</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>5f859da54b85634990a9560d7b7fe3e0</anchor>
      <arglist>(mxArray const *args[], int nargs, uMexOption const *options, int *next, mxArray const **optarg)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_bool</type>
      <name>vlmxIsOfClass</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>c629ff4443857a9b62f4fcf97685d251</anchor>
      <arglist>(mxArray const *array, mxClassID classId)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_bool</type>
      <name>vlmxIsReal</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>98f97abf05708722338eee548633c646</anchor>
      <arglist>(mxArray const *array)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_bool</type>
      <name>vlmxIsScalar</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>467ab633cf79af40612fd396f9210717</anchor>
      <arglist>(mxArray const *array)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_bool</type>
      <name>vlmxIsVector</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>f4e8c8fbc80faf0c72ba3302607267ed</anchor>
      <arglist>(mxArray const *array, vl_index numElements)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_bool</type>
      <name>vlmxIsMatrix</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>22990c0542dceaa97728420e7022853a</anchor>
      <arglist>(mxArray const *array, vl_index M, vl_index N)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_bool</type>
      <name>vlmxIsPlainScalar</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>0ab7a171db46b5a5a83dcf7b129f73bc</anchor>
      <arglist>(mxArray const *array)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_bool</type>
      <name>vlmxIsPlainVector</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>a75c1dfb92fd5ee50e9c908be1597e9e</anchor>
      <arglist>(mxArray const *array, vl_index numElements)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_bool</type>
      <name>vlmxIsPlainMatrix</name>
      <anchorfile>mexutils_8h.html</anchorfile>
      <anchor>fd490ce13cd220d411590f0218637de3</anchor>
      <arglist>(mxArray const *array, vl_index M, vl_index N)</arglist>
    </member>
    <docanchor file="mexutils_8h">mexutils-env</docanchor>
    <docanchor file="mexutils_8h">mexutils-array-test</docanchor>
    <docanchor file="mexutils_8h">mexutils-options</docanchor>
  </compound>
  <compound kind="file">
    <name>mser.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>mser_8c</filename>
    <includes id="mser_8h" name="mser.h" local="yes" imported="no">mser.h</includes>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>adv</name>
      <anchorfile>mser_8c.html</anchorfile>
      <anchor>38fd11a0ed64b6e3ed20c0deb94b6ec9</anchor>
      <arglist>(int ndims, int const *dims, int *subs)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_uint</type>
      <name>climb</name>
      <anchorfile>mser_8c.html</anchorfile>
      <anchor>05d6daa3b27d534bcf8209e40bcac008</anchor>
      <arglist>(VlMserReg *r, vl_uint idx)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlMserFilt *</type>
      <name>vl_mser_new</name>
      <anchorfile>mser_8c.html</anchorfile>
      <anchor>b48f4b5b4ce225847890acbe9727803a</anchor>
      <arglist>(int ndims, int const *dims)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_mser_delete</name>
      <anchorfile>mser_8c.html</anchorfile>
      <anchor>ed34dae689fa5b0826aca68196b7812a</anchor>
      <arglist>(VlMserFilt *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_mser_process</name>
      <anchorfile>mser_8c.html</anchorfile>
      <anchor>7e37b62fde731c80db068231be5953c3</anchor>
      <arglist>(VlMserFilt *f, vl_mser_pix const *im)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_mser_ell_fit</name>
      <anchorfile>mser_8c.html</anchorfile>
      <anchor>41015c5d5a9d8ae63ead0742d1bb9bd2</anchor>
      <arglist>(VlMserFilt *f)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>mser.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>mser_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <class kind="struct">_VlMserStats</class>
    <class kind="struct">_VlMserReg</class>
    <class kind="struct">_VlMserExtrReg</class>
    <class kind="struct">_VlMserFilt</class>
    <member kind="define">
      <type>#define</type>
      <name>VL_MSER_PIX_MAXVAL</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>b88df95be093992e6c90caf07711182a</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>VL_MSER_VOID_NODE</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>8dedc365f221c110cee8b0634ab86241</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>vl_uint8</type>
      <name>vl_mser_pix</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>5f6872cfbb7787c2a38cc2d5f138c716</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct _VlMserFilt</type>
      <name>VlMserFilt</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>508666acd5deff541468b65fa2f293ff</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct _VlMserStats</type>
      <name>VlMserStats</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>ed50184c1f1c7b19864a31918af124a8</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>float</type>
      <name>vl_mser_acc</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>4da3be7334e5383e02c829c53ddb9e34</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct _VlMserReg</type>
      <name>VlMserReg</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>773ec2215f4944379d40e5f0c3fa9e91</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct _VlMserExtrReg</type>
      <name>VlMserExtrReg</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>90014178f0814bd3bb87e895a6826639</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlMserFilt *</type>
      <name>vl_mser_new</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>b48f4b5b4ce225847890acbe9727803a</anchor>
      <arglist>(int ndims, int const *dims)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_mser_delete</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>ed34dae689fa5b0826aca68196b7812a</anchor>
      <arglist>(VlMserFilt *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_mser_process</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>7e37b62fde731c80db068231be5953c3</anchor>
      <arglist>(VlMserFilt *f, vl_mser_pix const *im)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_mser_ell_fit</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>41015c5d5a9d8ae63ead0742d1bb9bd2</anchor>
      <arglist>(VlMserFilt *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_uint</type>
      <name>vl_mser_get_regions_num</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>936317fc843d94055d4ccbf14e22be4b</anchor>
      <arglist>(VlMserFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_uint const *</type>
      <name>vl_mser_get_regions</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>95d36cf6a5273eed609eec066daba35c</anchor>
      <arglist>(VlMserFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE float const *</type>
      <name>vl_mser_get_ell</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>b2bc76608b4bd4e81124e9cbc7f27bcf</anchor>
      <arglist>(VlMserFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_uint</type>
      <name>vl_mser_get_ell_num</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>6318ea1ab44ccb1c8eede4c2cd9cb9fd</anchor>
      <arglist>(VlMserFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_uint</type>
      <name>vl_mser_get_ell_dof</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>08f3ee0189f4d9e5d89bb5d61ea168af</anchor>
      <arglist>(VlMserFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE VlMserStats const *</type>
      <name>vl_mser_get_stats</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>a852982b47d1d41263fd649a5db5b5d4</anchor>
      <arglist>(VlMserFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_mser_pix</type>
      <name>vl_mser_get_delta</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>789e7ecd354313b4af18af9207f8ad22</anchor>
      <arglist>(VlMserFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_mser_get_min_area</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>2a100a8dc3a054364b75a43b45bbc262</anchor>
      <arglist>(VlMserFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_mser_get_max_area</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>071a15b84638ca90b7e998fb5b907dcb</anchor>
      <arglist>(VlMserFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_mser_get_max_variation</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>1d714b4ec437ae6edf0fc7000a3d6c4e</anchor>
      <arglist>(VlMserFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_mser_get_min_diversity</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>f5fe1d0467baa438ebebf6826011a831</anchor>
      <arglist>(VlMserFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_mser_set_delta</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>0afbeb853949ef2a7fcb33e21e11b1dc</anchor>
      <arglist>(VlMserFilt *f, vl_mser_pix x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_mser_set_min_area</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>40307a368d49bf57efccd238f4a7dbe8</anchor>
      <arglist>(VlMserFilt *f, double x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_mser_set_max_area</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>05570036dcd5910354f30566f9577968</anchor>
      <arglist>(VlMserFilt *f, double x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_mser_set_max_variation</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>2c3ba326ea007046171643ce8a42688e</anchor>
      <arglist>(VlMserFilt *f, double x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_mser_set_min_diversity</name>
      <anchorfile>mser_8h.html</anchorfile>
      <anchor>7347f25a1e2db8804d072f76e5a320a0</anchor>
      <arglist>(VlMserFilt *f, double x)</arglist>
    </member>
    <docanchor file="mser_8h">mser-ell</docanchor>
    <docanchor file="mser_8h">mser</docanchor>
    <docanchor file="mser_8h">mser-vol</docanchor>
    <docanchor file="mser_8h">mser-algo</docanchor>
    <docanchor file="mser_8h">mser-definition</docanchor>
  </compound>
  <compound kind="file">
    <name>pgm.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>pgm_8c</filename>
    <includes id="pgm_8h" name="pgm.h" local="yes" imported="no">pgm.h</includes>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>remove_line</name>
      <anchorfile>pgm_8c.html</anchorfile>
      <anchor>ec39fb8104ed58ac87b75e896fbb7ceb</anchor>
      <arglist>(FILE *f)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static int</type>
      <name>remove_blanks</name>
      <anchorfile>pgm_8c.html</anchorfile>
      <anchor>7160d7d1836b470963d12b4e5997ea62</anchor>
      <arglist>(FILE *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_get_npixels</name>
      <anchorfile>pgm_8c.html</anchorfile>
      <anchor>4dc12635abcedee5db136e2224fc2c3f</anchor>
      <arglist>(VlPgmImage const *im)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_get_bpp</name>
      <anchorfile>pgm_8c.html</anchorfile>
      <anchor>68af5379b71150dfa5eefa74ad64da12</anchor>
      <arglist>(VlPgmImage const *im)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_extract_head</name>
      <anchorfile>pgm_8c.html</anchorfile>
      <anchor>3422ebbccb3203c14c8d5621e6b88b23</anchor>
      <arglist>(FILE *f, VlPgmImage *im)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_extract_data</name>
      <anchorfile>pgm_8c.html</anchorfile>
      <anchor>99c15e89a4e6593d24bca1cca88e68fa</anchor>
      <arglist>(FILE *f, VlPgmImage const *im, void *data)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_insert</name>
      <anchorfile>pgm_8c.html</anchorfile>
      <anchor>b5851ee8f50b454e09cbfdb006580741</anchor>
      <arglist>(FILE *f, VlPgmImage const *im, void const *data)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_read_new</name>
      <anchorfile>pgm_8c.html</anchorfile>
      <anchor>6e1f93a68fc9b6ee37dc2b48338a3ee8</anchor>
      <arglist>(char const *name, VlPgmImage *im, vl_uint8 **data)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_read_new_f</name>
      <anchorfile>pgm_8c.html</anchorfile>
      <anchor>a402a9d01da1ad00238b6e462de8f682</anchor>
      <arglist>(char const *name, VlPgmImage *im, float **data)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_write</name>
      <anchorfile>pgm_8c.html</anchorfile>
      <anchor>71ad31822b846c3bc5b1a1aeaec26a55</anchor>
      <arglist>(char const *name, vl_uint8 const *data, int width, int height)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_write_f</name>
      <anchorfile>pgm_8c.html</anchorfile>
      <anchor>a4d1433fc6fa1f6a69be8a1b4876620e</anchor>
      <arglist>(char const *name, float const *data, int width, int height)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>pgm.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>pgm_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <includes id="mathop_8h" name="mathop.h" local="yes" imported="no">mathop.h</includes>
    <class kind="struct">_VlPgmImage</class>
    <member kind="typedef">
      <type>struct _VlPgmImage</type>
      <name>VlPgmImage</name>
      <anchorfile>pgm_8h.html</anchorfile>
      <anchor>fdb30d58eea93f6e3a6016da6ff9ba6f</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_extract_head</name>
      <anchorfile>pgm_8h.html</anchorfile>
      <anchor>3422ebbccb3203c14c8d5621e6b88b23</anchor>
      <arglist>(FILE *f, VlPgmImage *im)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_extract_data</name>
      <anchorfile>pgm_8h.html</anchorfile>
      <anchor>99c15e89a4e6593d24bca1cca88e68fa</anchor>
      <arglist>(FILE *f, VlPgmImage const *im, void *data)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_insert</name>
      <anchorfile>pgm_8h.html</anchorfile>
      <anchor>b5851ee8f50b454e09cbfdb006580741</anchor>
      <arglist>(FILE *f, VlPgmImage const *im, void const *data)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_get_npixels</name>
      <anchorfile>pgm_8h.html</anchorfile>
      <anchor>4dc12635abcedee5db136e2224fc2c3f</anchor>
      <arglist>(VlPgmImage const *im)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_get_bpp</name>
      <anchorfile>pgm_8h.html</anchorfile>
      <anchor>68af5379b71150dfa5eefa74ad64da12</anchor>
      <arglist>(VlPgmImage const *im)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_write</name>
      <anchorfile>pgm_8h.html</anchorfile>
      <anchor>71ad31822b846c3bc5b1a1aeaec26a55</anchor>
      <arglist>(char const *name, vl_uint8 const *data, int width, int height)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_write_f</name>
      <anchorfile>pgm_8h.html</anchorfile>
      <anchor>a4d1433fc6fa1f6a69be8a1b4876620e</anchor>
      <arglist>(char const *name, float const *data, int width, int height)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_read_new</name>
      <anchorfile>pgm_8h.html</anchorfile>
      <anchor>6e1f93a68fc9b6ee37dc2b48338a3ee8</anchor>
      <arglist>(char const *name, VlPgmImage *im, vl_uint8 **data)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_pgm_read_new_f</name>
      <anchorfile>pgm_8h.html</anchorfile>
      <anchor>a402a9d01da1ad00238b6e462de8f682</anchor>
      <arglist>(char const *name, VlPgmImage *im, float **data)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>quickshift.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>quickshift_8c</filename>
    <includes id="quickshift_8h" name="quickshift.h" local="yes" imported="no">quickshift.h</includes>
    <member kind="function">
      <type>VL_INLINE vl_qs_type</type>
      <name>vl_quickshift_distance</name>
      <anchorfile>quickshift_8c.html</anchorfile>
      <anchor>5b631210954fadee8307dbe3e0c390a4</anchor>
      <arglist>(vl_qs_type const *I, int N1, int N2, int K, int i1, int i2, int j1, int j2)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_qs_type</type>
      <name>vl_quickshift_inner</name>
      <anchorfile>quickshift_8c.html</anchorfile>
      <anchor>7c255531567c9fc0901d2838cf187506</anchor>
      <arglist>(vl_qs_type const *I, int N1, int N2, int K, int i1, int i2, int j1, int j2)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlQS *</type>
      <name>vl_quickshift_new</name>
      <anchorfile>quickshift_8c.html</anchorfile>
      <anchor>ba6d1de6ef02159d32b150d0cbd42e43</anchor>
      <arglist>(vl_qs_type const *image, int height, int width, int channels)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_quickshift_process</name>
      <anchorfile>quickshift_8c.html</anchorfile>
      <anchor>05bf3f111b773be56885a04b5a4acec3</anchor>
      <arglist>(VlQS *q)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>vl_quickshift_delete</name>
      <anchorfile>quickshift_8c.html</anchorfile>
      <anchor>9c2a39344fb684d899f22faf358425e8</anchor>
      <arglist>(VlQS *q)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>quickshift.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>quickshift_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <includes id="mathop_8h" name="mathop.h" local="yes" imported="no">mathop.h</includes>
    <class kind="struct">_VlQS</class>
    <member kind="typedef">
      <type>double</type>
      <name>vl_qs_type</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>ee7aaa0947ccf164d8072bd798f419e2</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct _VlQS</type>
      <name>VlQS</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>34e54cc961caac324f6ae94b12d5c439</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlQS *</type>
      <name>vl_quickshift_new</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>2c2cebc768665438e72ae0df9d4b8f90</anchor>
      <arglist>(vl_qs_type const *im, int height, int width, int channels)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_quickshift_delete</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>57eaf395257464663a748e5e93c1b2f1</anchor>
      <arglist>(VlQS *q)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_quickshift_process</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>05bf3f111b773be56885a04b5a4acec3</anchor>
      <arglist>(VlQS *q)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_qs_type</type>
      <name>vl_quickshift_get_max_dist</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>c8fff6a562325a5443db0c12e35e28bd</anchor>
      <arglist>(VlQS const *q)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_qs_type</type>
      <name>vl_quickshift_get_kernel_size</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>4025e5fe80574bde2adb94cf61e37349</anchor>
      <arglist>(VlQS const *q)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_bool</type>
      <name>vl_quickshift_get_medoid</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>7dc7ab7d3d4cc1a12fbcb2acb598449e</anchor>
      <arglist>(VlQS const *q)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int *</type>
      <name>vl_quickshift_get_parents</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>9696e73c86f83f69ad98ed470f382fcf</anchor>
      <arglist>(VlQS const *q)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_qs_type *</type>
      <name>vl_quickshift_get_dists</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>8de1b44a74784b234de94b7c2bf89152</anchor>
      <arglist>(VlQS const *q)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_qs_type *</type>
      <name>vl_quickshift_get_density</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>a0474a409b7d5e254d6c43a6c028716a</anchor>
      <arglist>(VlQS const *q)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_quickshift_set_max_dist</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>46d92fd3fb8ab441e245d77049b47662</anchor>
      <arglist>(VlQS *q, vl_qs_type tau)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_quickshift_set_kernel_size</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>e51dff2e67141fa85891a403298e987f</anchor>
      <arglist>(VlQS *q, vl_qs_type sigma)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_quickshift_set_medoid</name>
      <anchorfile>quickshift_8h.html</anchorfile>
      <anchor>fa281fe05150d1f4dd17dbbebde3a0b2</anchor>
      <arglist>(VlQS *q, vl_bool medoid)</arglist>
    </member>
    <docanchor file="quickshift_8h">quickshift-usage</docanchor>
    <docanchor file="quickshift_8h">quickshift-intro</docanchor>
    <docanchor file="quickshift_8h">quickshift-tech</docanchor>
  </compound>
  <compound kind="file">
    <name>random.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>random_8c</filename>
    <includes id="random_8h" name="random.h" local="yes" imported="no">random.h</includes>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_rand_get_state</name>
      <anchorfile>random_8c.html</anchorfile>
      <anchor>141067cb9547f9be84bda63d35e310c4</anchor>
      <arglist>(vl_uint32 state[625])</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_rand_set_state</name>
      <anchorfile>random_8c.html</anchorfile>
      <anchor>09000badf1a5c8d30c5a2de08140b14b</anchor>
      <arglist>(vl_uint32 const state[625])</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_rand_seed</name>
      <anchorfile>random_8c.html</anchorfile>
      <anchor>122610ebcb83e52bff323f27694bacf8</anchor>
      <arglist>(vl_uint32 s)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_rand_seed_by_array</name>
      <anchorfile>random_8c.html</anchorfile>
      <anchor>9d21af7f16a5b9818643bdf217875573</anchor>
      <arglist>(vl_uint32 const init_key[], int key_length)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT vl_uint32</type>
      <name>vl_rand_uint32</name>
      <anchorfile>random_8c.html</anchorfile>
      <anchor>d86f024c0b55aa91ad808e9770b00f4e</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT vl_int32</type>
      <name>vl_rand_int31</name>
      <anchorfile>random_8c.html</anchorfile>
      <anchor>5a3785bc9b75b46111aa4b964127086e</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT double</type>
      <name>vl_rand_real1</name>
      <anchorfile>random_8c.html</anchorfile>
      <anchor>5df0aa81a11991e5de01a5787f478d06</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT double</type>
      <name>vl_rand_real2</name>
      <anchorfile>random_8c.html</anchorfile>
      <anchor>49dec6498d166f03b797c1f96655e074</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT double</type>
      <name>vl_rand_real3</name>
      <anchorfile>random_8c.html</anchorfile>
      <anchor>f4dce699e5fbecd0391d7eb4e65ac7da</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT double</type>
      <name>vl_rand_res53</name>
      <anchorfile>random_8c.html</anchorfile>
      <anchor>8c16d46dea8a4f9699315a7cb92c3950</anchor>
      <arglist>()</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>random.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>random_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_rand_set_state</name>
      <anchorfile>random_8h.html</anchorfile>
      <anchor>09000badf1a5c8d30c5a2de08140b14b</anchor>
      <arglist>(vl_uint32 const state[625])</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_rand_get_state</name>
      <anchorfile>random_8h.html</anchorfile>
      <anchor>a27218781133505bde0e0566ae278c04</anchor>
      <arglist>(vl_uint32 *state)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_rand_seed</name>
      <anchorfile>random_8h.html</anchorfile>
      <anchor>122610ebcb83e52bff323f27694bacf8</anchor>
      <arglist>(vl_uint32 s)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_rand_seed_by_array</name>
      <anchorfile>random_8h.html</anchorfile>
      <anchor>9d21af7f16a5b9818643bdf217875573</anchor>
      <arglist>(vl_uint32 const init_key[], int key_length)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT vl_uint32</type>
      <name>vl_rand_uint32</name>
      <anchorfile>random_8h.html</anchorfile>
      <anchor>d86f024c0b55aa91ad808e9770b00f4e</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT vl_int32</type>
      <name>vl_rand_int31</name>
      <anchorfile>random_8h.html</anchorfile>
      <anchor>5a3785bc9b75b46111aa4b964127086e</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT double</type>
      <name>vl_rand_real1</name>
      <anchorfile>random_8h.html</anchorfile>
      <anchor>5df0aa81a11991e5de01a5787f478d06</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT double</type>
      <name>vl_rand_real2</name>
      <anchorfile>random_8h.html</anchorfile>
      <anchor>49dec6498d166f03b797c1f96655e074</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT double</type>
      <name>vl_rand_real3</name>
      <anchorfile>random_8h.html</anchorfile>
      <anchor>f4dce699e5fbecd0391d7eb4e65ac7da</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT double</type>
      <name>vl_rand_res53</name>
      <anchorfile>random_8h.html</anchorfile>
      <anchor>8c16d46dea8a4f9699315a7cb92c3950</anchor>
      <arglist>()</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>rodrigues.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>rodrigues_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_rodrigues</name>
      <anchorfile>rodrigues_8h.html</anchorfile>
      <anchor>ec6fdd46a266dd08867f7a3ed12548ca</anchor>
      <arglist>(double *R_pt, double *dR_pt, const double *om_pt)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_irodrigues</name>
      <anchorfile>rodrigues_8h.html</anchorfile>
      <anchor>66236533102effbbc0e96827c06d1c60</anchor>
      <arglist>(double *om_pt, double *dom_pt, const double *R_pt)</arglist>
    </member>
    <docanchor file="rodrigues_8h">rodrigues</docanchor>
  </compound>
  <compound kind="file">
    <name>sift.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>sift_8c</filename>
    <includes id="sift_8h" name="sift.h" local="yes" imported="no">sift.h</includes>
    <includes id="imop_8h" name="imop.h" local="yes" imported="no">imop.h</includes>
    <includes id="mathop_8h" name="mathop.h" local="yes" imported="no">mathop.h</includes>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>fast_expn</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>54a28f7f095a58401a7917073f43866f</anchor>
      <arglist>(double x)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>fast_expn_init</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>c0f5ab6b07f3edd4728f6c7439f886f4</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>copy_and_upsample_rows</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>eb42c89bf4510234d60ba3eef7010c29</anchor>
      <arglist>(vl_sift_pix *dst, vl_sift_pix const *src, int width, int height)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>copy_and_downsample</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>457daa5f995f4b946c1a44a45e7702bb</anchor>
      <arglist>(vl_sift_pix *dst, vl_sift_pix const *src, int width, int height, int d)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlSiftFilt *</type>
      <name>vl_sift_new</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>7430415e1978727a55a29f203eb38d3e</anchor>
      <arglist>(int width, int height, int noctaves, int nlevels, int o_min)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_sift_delete</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>bcf6b47f064329813fa54d80310728cd</anchor>
      <arglist>(VlSiftFilt *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_sift_process_first_octave</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>774f028cadf0fc556bfd6170eb0033b9</anchor>
      <arglist>(VlSiftFilt *f, vl_sift_pix const *im)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_sift_process_next_octave</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>a46dad3788e44ffb6aed2ccb8c445c2d</anchor>
      <arglist>(VlSiftFilt *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_sift_detect</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>248f0925ed45fa4632ea30fa9b2229af</anchor>
      <arglist>(VlSiftFilt *f)</arglist>
    </member>
    <member kind="function" static="yes">
      <type>static void</type>
      <name>update_gradient</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>ce1fba61b0cc6ad7b1b0f9a07eabdf87</anchor>
      <arglist>(VlSiftFilt *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_sift_calc_keypoint_orientations</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>b38b0a5d98e491762041e7378355b7b6</anchor>
      <arglist>(VlSiftFilt *f, double angles[4], VlSiftKeypoint const *k)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_sift_pix</type>
      <name>normalize_histogram</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>b7319c742b088d2629f388b714baa996</anchor>
      <arglist>(vl_sift_pix *begin, vl_sift_pix *end)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_sift_calc_raw_descriptor</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>3d537eb2a200c3c19e9a751178d1b9b5</anchor>
      <arglist>(VlSiftFilt const *f, vl_sift_pix const *grad, vl_sift_pix *descr, int width, int height, double x, double y, double sigma, double angle0)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_sift_calc_keypoint_descriptor</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>d5021ed313da8e8c2d0174f711df6b0e</anchor>
      <arglist>(VlSiftFilt *f, vl_sift_pix *descr, VlSiftKeypoint const *k, double angle0)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_sift_keypoint_init</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>445bbb5bcedabfa3c16df83d1817cd8d</anchor>
      <arglist>(VlSiftFilt const *f, VlSiftKeypoint *k, double x, double y, double sigma)</arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>expn_tab</name>
      <anchorfile>sift_8c.html</anchorfile>
      <anchor>6bfe7ecf9f4b9125e9613e90e4dc8971</anchor>
      <arglist>[EXPN_SZ+1]</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>sift.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>sift_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <class kind="struct">_VlSiftKeypoint</class>
    <class kind="struct">_VlSiftFilt</class>
    <member kind="typedef">
      <type>float</type>
      <name>vl_sift_pix</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>7efac4fb08e4642f12ef439ac376a5cc</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct _VlSiftKeypoint</type>
      <name>VlSiftKeypoint</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>1f9c346f4db4668f708620105d237089</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct _VlSiftFilt</type>
      <name>VlSiftFilt</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>6c49cfe67a3b6628b2edadd5f0a31345</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT VlSiftFilt *</type>
      <name>vl_sift_new</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>7430415e1978727a55a29f203eb38d3e</anchor>
      <arglist>(int width, int height, int noctaves, int nlevels, int o_min)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_sift_delete</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>bcf6b47f064329813fa54d80310728cd</anchor>
      <arglist>(VlSiftFilt *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_sift_process_first_octave</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>774f028cadf0fc556bfd6170eb0033b9</anchor>
      <arglist>(VlSiftFilt *f, vl_sift_pix const *im)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_sift_process_next_octave</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>a46dad3788e44ffb6aed2ccb8c445c2d</anchor>
      <arglist>(VlSiftFilt *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_sift_detect</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>248f0925ed45fa4632ea30fa9b2229af</anchor>
      <arglist>(VlSiftFilt *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_sift_calc_keypoint_orientations</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>b38b0a5d98e491762041e7378355b7b6</anchor>
      <arglist>(VlSiftFilt *f, double angles[4], VlSiftKeypoint const *k)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_sift_calc_keypoint_descriptor</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>8631e63443c1faa7069a4e8e885fd82d</anchor>
      <arglist>(VlSiftFilt *f, vl_sift_pix *descr, VlSiftKeypoint const *k, double angle)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_sift_calc_raw_descriptor</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>3ddb5d720d7452b25aee72957ae17326</anchor>
      <arglist>(VlSiftFilt const *f, vl_sift_pix const *image, vl_sift_pix *descr, int widht, int height, double x, double y, double s, double angle0)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT void</type>
      <name>vl_sift_keypoint_init</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>445bbb5bcedabfa3c16df83d1817cd8d</anchor>
      <arglist>(VlSiftFilt const *f, VlSiftKeypoint *k, double x, double y, double sigma)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_sift_get_octave_index</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>5dae5aa2347a081376aba54c1b77c414</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_sift_get_noctaves</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>d5c0f055523426543f1692270cec3bc6</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_sift_get_octave_first</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>9d65b00c7709fff216f590dfaefd87b9</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_sift_get_octave_width</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>5d04844056daf18bdd9ad581e4f716eb</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_sift_get_octave_height</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>d5b6d41bea03ce9fef51ba477260cd7e</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_sift_get_nlevels</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>577b511ac7e6a7ee817600e53a16c02e</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE int</type>
      <name>vl_sift_get_nkeypoints</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>885282c3675e54aeca2588539b4aa172</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_sift_get_peak_thresh</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>18b7b7caf2ee738d183b66f0460fe901</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_sift_get_edge_thresh</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>e1737c7781dc348a5213c9ca9bd431f4</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_sift_get_norm_thresh</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>e2897ba8ef4b74754d3ce273a7019cb5</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_sift_get_magnif</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>00459cfdd6789c858b315b014df6b2dd</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE double</type>
      <name>vl_sift_get_window_size</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>44e8b09726d12f6638323f988394be7f</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE vl_sift_pix *</type>
      <name>vl_sift_get_octave</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>9cc1c77b8fc49875017557096539acb6</anchor>
      <arglist>(VlSiftFilt const *f, int s)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE VlSiftKeypoint const *</type>
      <name>vl_sift_get_keypoints</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>d00c6f384a9b50f185cf7acc68e68fbd</anchor>
      <arglist>(VlSiftFilt const *f)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_sift_set_peak_thresh</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>6d8ec661531dcb178e2af6a4d972adf2</anchor>
      <arglist>(VlSiftFilt *f, double t)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_sift_set_edge_thresh</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>a9751401dd0725a914d18773eb91ef50</anchor>
      <arglist>(VlSiftFilt *f, double t)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_sift_set_norm_thresh</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>257cde10c952f7a9887d3a2cfe8627f4</anchor>
      <arglist>(VlSiftFilt *f, double t)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_sift_set_magnif</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>012256fc78aebba2466f4f39ae0f3b94</anchor>
      <arglist>(VlSiftFilt *f, double m)</arglist>
    </member>
    <member kind="function">
      <type>VL_INLINE void</type>
      <name>vl_sift_set_window_size</name>
      <anchorfile>sift_8h.html</anchorfile>
      <anchor>ecb9118a69d46538a22db37e021f2f2c</anchor>
      <arglist>(VlSiftFilt *f, double x)</arglist>
    </member>
    <docanchor file="sift_8h">sift-tech-descriptor-std</docanchor>
    <docanchor file="sift_8h">sift-tech-detector-edge</docanchor>
    <docanchor file="sift_8h">sift-tech-ss</docanchor>
    <docanchor file="sift_8h">sift-tech</docanchor>
    <docanchor file="sift_8h">sift-tech-descriptor-can</docanchor>
    <docanchor file="sift_8h">sift</docanchor>
    <docanchor file="sift_8h">sift-tech-descriptor</docanchor>
    <docanchor file="sift_8h">sift-tech-descriptor-image</docanchor>
    <docanchor file="sift_8h">sift-intro-extensions</docanchor>
    <docanchor file="sift_8h">sift-usage</docanchor>
    <docanchor file="sift_8h">sift-intro-descriptor</docanchor>
    <docanchor file="sift_8h">sift-intro-detector</docanchor>
    <docanchor file="sift_8h">sift-tech-detector-orientation</docanchor>
    <docanchor file="sift_8h">sift-tech-detector</docanchor>
    <docanchor file="sift_8h">sift-tech-detector-peak</docanchor>
    <docanchor file="sift_8h">sift-intro</docanchor>
  </compound>
  <compound kind="file">
    <name>stringop.c</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>stringop_8c</filename>
    <includes id="stringop_8h" name="stringop.h" local="yes" imported="no">stringop.h</includes>
    <member kind="function">
      <type>VL_EXPORT char *</type>
      <name>vl_string_parse_protocol</name>
      <anchorfile>stringop_8c.html</anchorfile>
      <anchor>cd79697750f77dd5f4e7625a0c6ead80</anchor>
      <arglist>(char const *str, int *prot)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT char const *</type>
      <name>vl_string_protocol_name</name>
      <anchorfile>stringop_8c.html</anchorfile>
      <anchor>a126b776a59d7c7b8c1730d3590b214f</anchor>
      <arglist>(int prot)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_string_basename</name>
      <anchorfile>stringop_8c.html</anchorfile>
      <anchor>f661aae9970783d36d55b3ab33f2fb0d</anchor>
      <arglist>(char *dst, int n, char const *src, int n_ext)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_string_replace_wildcard</name>
      <anchorfile>stringop_8c.html</anchorfile>
      <anchor>ffd8371ccabab1d5cb8d31769f7cb8ec</anchor>
      <arglist>(char *dst, int n, char const *src, char wild, char esc, char const *repl)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_string_copy</name>
      <anchorfile>stringop_8c.html</anchorfile>
      <anchor>5f3f9965facab98b4044ab410a7cc792</anchor>
      <arglist>(char *dst, int n, char const *src)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_string_copy_sub</name>
      <anchorfile>stringop_8c.html</anchorfile>
      <anchor>7681afceaaa0070dc89033610419b319</anchor>
      <arglist>(char *dst, int n, char const *beg, char const *end)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT char *</type>
      <name>vl_string_find_char_rev</name>
      <anchorfile>stringop_8c.html</anchorfile>
      <anchor>88505b9aaf130e6cf0085caca065b591</anchor>
      <arglist>(char const *beg, char const *end, char c)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_string_length</name>
      <anchorfile>stringop_8c.html</anchorfile>
      <anchor>c8c41933ba6eb99fdab908185cc6c2d7</anchor>
      <arglist>(char const *str)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_string_casei_cmp</name>
      <anchorfile>stringop_8c.html</anchorfile>
      <anchor>63ce92ecf43b0bca5564afe84283db10</anchor>
      <arglist>(const char *s1, const char *s2)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>stringop.h</name>
    <path>/Users/vedaldi/Documents/Projects/vlfeat/vl/</path>
    <filename>stringop_8h</filename>
    <includes id="generic_8h" name="generic.h" local="yes" imported="no">generic.h</includes>
    <member kind="enumvalue">
      <name>VL_PROT_UNKNOWN</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>dc29c2ff13d900c2f185ee95427fb06c71fca21ec3ae6a26edbe380fedc2ebec</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>VL_PROT_NONE</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>dc29c2ff13d900c2f185ee95427fb06c94b2ad9436eeeb7e7a08baf24e00f3d6</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>VL_PROT_ASCII</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>dc29c2ff13d900c2f185ee95427fb06c611cc6138919fdd98ce2a9137a762b91</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>VL_PROT_BINARY</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>dc29c2ff13d900c2f185ee95427fb06ca92055b1172e1b8fa98177304d495653</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_string_copy</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>5f3f9965facab98b4044ab410a7cc792</anchor>
      <arglist>(char *dst, int n, char const *src)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_string_copy_sub</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>7681afceaaa0070dc89033610419b319</anchor>
      <arglist>(char *dst, int n, char const *beg, char const *end)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT char *</type>
      <name>vl_string_parse_protocol</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>cd79697750f77dd5f4e7625a0c6ead80</anchor>
      <arglist>(char const *str, int *prot)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT char const *</type>
      <name>vl_string_protocol_name</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>a126b776a59d7c7b8c1730d3590b214f</anchor>
      <arglist>(int prot)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_string_basename</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>f661aae9970783d36d55b3ab33f2fb0d</anchor>
      <arglist>(char *dst, int n, char const *src, int n_ext)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_string_replace_wildcard</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>ffd8371ccabab1d5cb8d31769f7cb8ec</anchor>
      <arglist>(char *dst, int n, char const *src, char wild, char esc, char const *repl)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT char *</type>
      <name>vl_string_find_char_rev</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>88505b9aaf130e6cf0085caca065b591</anchor>
      <arglist>(char const *beg, char const *end, char c)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_string_length</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>c8c41933ba6eb99fdab908185cc6c2d7</anchor>
      <arglist>(char const *str)</arglist>
    </member>
    <member kind="function">
      <type>VL_EXPORT int</type>
      <name>vl_string_casei_cmp</name>
      <anchorfile>stringop_8h.html</anchorfile>
      <anchor>63ce92ecf43b0bca5564afe84283db10</anchor>
      <arglist>(const char *s1, const char *s2)</arglist>
    </member>
    <docanchor file="stringop_8h">vl-stringop-err</docanchor>
  </compound>
  <compound kind="struct">
    <name>_uMexOption</name>
    <filename>struct__uMexOption.html</filename>
    <member kind="variable">
      <type>const char *</type>
      <name>name</name>
      <anchorfile>struct__uMexOption.html</anchorfile>
      <anchor>a69e5a75c96291293fb0ee0c48699e08</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>has_arg</name>
      <anchorfile>struct__uMexOption.html</anchorfile>
      <anchor>3a190a6116e752092cf079af89cee74c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>val</name>
      <anchorfile>struct__uMexOption.html</anchorfile>
      <anchor>d412b9b44bc226fe56503cd6e79eb59f</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlAIB</name>
    <filename>struct__VlAIB.html</filename>
    <member kind="variable">
      <type>vl_uint *</type>
      <name>nodes</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>73803e0cf9976751c90601176135a5b3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint</type>
      <name>nentries</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>7e310da83a4b13d5b0e4a5f9ff31dbbf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double *</type>
      <name>beta</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>70b3605ba8827169b90ab381a8cf8109</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint *</type>
      <name>bidx</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>4e91b088dc86b990ab288ca6a60f0169</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint *</type>
      <name>which</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>fb26530f18020afc2256299a9a5b7953</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint</type>
      <name>nwhich</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>d4109a8fef7a2c65d0f44e3be3445383</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double *</type>
      <name>Pcx</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>bfc0c209c22acdbd1b34a5af91b1cb85</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double *</type>
      <name>Px</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>d9e572f80ee4f60b1870ee49abceea57</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double *</type>
      <name>Pc</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>55615454e6cce01f25cdb53d3fd9c9bc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint</type>
      <name>nvalues</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>42f6fe7a96b7db033f78a5ffc72d717a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint</type>
      <name>nlabels</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>280b8f0cef4b0ebe01238d19c0fc2993</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint *</type>
      <name>parents</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>f5e9d01a6c18fc15a75f24445c52ad58</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double *</type>
      <name>costs</name>
      <anchorfile>struct__VlAIB.html</anchorfile>
      <anchor>300dfe014834183cc69758251fa224ec</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlFileMeta</name>
    <filename>struct__VlFileMeta.html</filename>
    <member kind="variable">
      <type>vl_bool</type>
      <name>active</name>
      <anchorfile>struct__VlFileMeta.html</anchorfile>
      <anchor>34e1e6f9855a14d604a6bd81a7d23ce8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char</type>
      <name>pattern</name>
      <anchorfile>struct__VlFileMeta.html</anchorfile>
      <anchor>a72b9af83e130b9f9c3b34967abcab6d</anchor>
      <arglist>[1024]</arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>protocol</name>
      <anchorfile>struct__VlFileMeta.html</anchorfile>
      <anchor>66ea7ca6261b1001d264490849e6a3b3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char</type>
      <name>name</name>
      <anchorfile>struct__VlFileMeta.html</anchorfile>
      <anchor>5bc45347f10fddf076f4a7341ea866e0</anchor>
      <arglist>[1024]</arglist>
    </member>
    <member kind="variable">
      <type>FILE *</type>
      <name>file</name>
      <anchorfile>struct__VlFileMeta.html</anchorfile>
      <anchor>1b3955a31af9e3b541b603a6d3fdf552</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlHeap</name>
    <filename>struct__VlHeap.html</filename>
  </compound>
  <compound kind="struct">
    <name>_VlHIKMNode</name>
    <filename>struct__VlHIKMNode.html</filename>
    <member kind="variable">
      <type>VlIKMFilt *</type>
      <name>filter</name>
      <anchorfile>struct__VlHIKMNode.html</anchorfile>
      <anchor>66f14d46edce6daad056135a87da0b0e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct _VlHIKMNode **</type>
      <name>children</name>
      <anchorfile>struct__VlHIKMNode.html</anchorfile>
      <anchor>10b2c03e6cf2b913c45ad98ca3c0ae90</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlHIKMTree</name>
    <filename>struct__VlHIKMTree.html</filename>
    <member kind="variable">
      <type>int</type>
      <name>M</name>
      <anchorfile>struct__VlHIKMTree.html</anchorfile>
      <anchor>dce7607b93c804c89c91c7cfdfd26e2a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>K</name>
      <anchorfile>struct__VlHIKMTree.html</anchorfile>
      <anchor>501435ec5f0455d1784065064de0b047</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>max_niters</name>
      <anchorfile>struct__VlHIKMTree.html</anchorfile>
      <anchor>d2cc8dffa9829085fd024946244f5913</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>method</name>
      <anchorfile>struct__VlHIKMTree.html</anchorfile>
      <anchor>dd658e847336e0e1fcced546f95a5242</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>verb</name>
      <anchorfile>struct__VlHIKMTree.html</anchorfile>
      <anchor>68c00fcb8ee6a39a2a8e81982b4df74a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>depth</name>
      <anchorfile>struct__VlHIKMTree.html</anchorfile>
      <anchor>14171ed046d1014452cdf77e10ca8a65</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VlHIKMNode *</type>
      <name>root</name>
      <anchorfile>struct__VlHIKMTree.html</anchorfile>
      <anchor>7c7699d70ecf56d15892c5b79a7cfa25</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlIKMFilt</name>
    <filename>struct__VlIKMFilt.html</filename>
    <member kind="variable">
      <type>int</type>
      <name>M</name>
      <anchorfile>struct__VlIKMFilt.html</anchorfile>
      <anchor>d603f4e16a822a496637801bd8aa0ffa</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>K</name>
      <anchorfile>struct__VlIKMFilt.html</anchorfile>
      <anchor>2bce01c2f4442df0cae4b7e206794b70</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>method</name>
      <anchorfile>struct__VlIKMFilt.html</anchorfile>
      <anchor>aee08b8d0b9cb297745bf8abe3b1f871</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>max_niters</name>
      <anchorfile>struct__VlIKMFilt.html</anchorfile>
      <anchor>41b7d05e312080dbb24d31f7c73431de</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>verb</name>
      <anchorfile>struct__VlIKMFilt.html</anchorfile>
      <anchor>bce392916c4be49457fac5c7012cce0c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_ikm_acc *</type>
      <name>centers</name>
      <anchorfile>struct__VlIKMFilt.html</anchorfile>
      <anchor>6117db7573f0514fa86c7cd35233e899</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_ikm_acc *</type>
      <name>inter_dist</name>
      <anchorfile>struct__VlIKMFilt.html</anchorfile>
      <anchor>9939fd238fbd03e340db098e8fc71c0e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlKDForest</name>
    <filename>struct__VlKDForest.html</filename>
  </compound>
  <compound kind="struct">
    <name>_VlKDForestNeighbor</name>
    <filename>struct__VlKDForestNeighbor.html</filename>
    <member kind="variable">
      <type>float</type>
      <name>distance</name>
      <anchorfile>struct__VlKDForestNeighbor.html</anchorfile>
      <anchor>3ab9a0a6d3e6340980c5fdd70356fe88</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>unsigned int</type>
      <name>index</name>
      <anchorfile>struct__VlKDForestNeighbor.html</anchorfile>
      <anchor>d77011fd794be4378b281877102407fb</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlMserExtrReg</name>
    <filename>struct__VlMserExtrReg.html</filename>
    <member kind="variable">
      <type>int</type>
      <name>parent</name>
      <anchorfile>struct__VlMserExtrReg.html</anchorfile>
      <anchor>0d46082e19cc2d19499885bf55869ac0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>index</name>
      <anchorfile>struct__VlMserExtrReg.html</anchorfile>
      <anchor>900131b01ddafbd08802ff0b1cc347cd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_mser_pix</type>
      <name>value</name>
      <anchorfile>struct__VlMserExtrReg.html</anchorfile>
      <anchor>3331e37d4887ad3c6be58f30469193e9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint</type>
      <name>shortcut</name>
      <anchorfile>struct__VlMserExtrReg.html</anchorfile>
      <anchor>c8a5fc0e94e6af0544128152d5b2913a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint</type>
      <name>area</name>
      <anchorfile>struct__VlMserExtrReg.html</anchorfile>
      <anchor>8bbb88c39f2a0357ec800c7ec2e995ab</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>float</type>
      <name>variation</name>
      <anchorfile>struct__VlMserExtrReg.html</anchorfile>
      <anchor>e22728ff23576575b7a029dc834bedd4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint</type>
      <name>max_stable</name>
      <anchorfile>struct__VlMserExtrReg.html</anchorfile>
      <anchor>f0be4f91bfc84308adae137df23c363e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlMserFilt</name>
    <filename>struct__VlMserFilt.html</filename>
    <member kind="variable">
      <type>vl_uint *</type>
      <name>perm</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>2fcb95025e3add3bb4c66e012b59c674</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint *</type>
      <name>joins</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>53678697276462d93c85d3d9582f91a4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>njoins</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>98e036a9c487bb190ea0c82c27d003c1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>ndims</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>648c78458f1bb861001dddc6fa5f3fb5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int *</type>
      <name>dims</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>82bbe3283589900a1c714b9cff5adb28</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>nel</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>c244f7dbf6770b7abaa499c0b2668713</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int *</type>
      <name>subs</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>40a05eecb2b6c05a4f48eb78f5c9c2ce</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int *</type>
      <name>dsubs</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>05a97268708deb79c10e493048d5d611</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int *</type>
      <name>strides</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>ec6af64d355cc563eb3b19e9d4e78a4a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VlMserReg *</type>
      <name>r</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>9d276f70fa36e0845916eba2b0c8e373</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VlMserExtrReg *</type>
      <name>er</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>09e56c5cb69c7eb748944c2b832e469f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint *</type>
      <name>mer</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>ef30725cbe6c253ebe872f1232dc7fa1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>ner</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>07d20fc1410196053c35c48aba8ca57d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>nmer</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>f25e21988101017a6b03fff5b42ca45d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>rer</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>a3d78d131fe20fa4635ca769ac29d8a7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>rmer</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>9e0875c01ff0e66d80ab9d31284c30f6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>float *</type>
      <name>acc</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>fb7739b31b69683c9577c45b0f575550</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>float *</type>
      <name>ell</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>cda31be12cdaba0db7e642265ce68420</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>rell</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>e896c3f0e62c251d28dc67a617f3732b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>nell</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>4ec538f934bbba6a58d9241e2a28f86c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>dof</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>6bfd65fc47a83667c2473c3909f5ce73</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_bool</type>
      <name>verbose</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>cb7ad50f5a3b47d640320d2b9931f515</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>delta</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>f65e7c3ab76f8a83a924443f108d677d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>max_area</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>8ff871d80f75a6c07761147c8c78361c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>min_area</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>6dbc3d8bc02f60da5c172f15996c8360</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>max_variation</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>ece32e6c0fb7092eedd03b01422451ea</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>min_diversity</name>
      <anchorfile>struct__VlMserFilt.html</anchorfile>
      <anchor>7a742a648c06a2bca07de02d16c92dee</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlMserReg</name>
    <filename>struct__VlMserReg.html</filename>
    <member kind="variable">
      <type>vl_uint</type>
      <name>parent</name>
      <anchorfile>struct__VlMserReg.html</anchorfile>
      <anchor>fed46381d2ac26edc26dfe3a12d3aa23</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint</type>
      <name>shortcut</name>
      <anchorfile>struct__VlMserReg.html</anchorfile>
      <anchor>e7c8cc1abc96d7bc40eb80fe987fe69c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint</type>
      <name>height</name>
      <anchorfile>struct__VlMserReg.html</anchorfile>
      <anchor>1a6c11f9514eb4c8aaf78a0bce94f6f3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_uint</type>
      <name>area</name>
      <anchorfile>struct__VlMserReg.html</anchorfile>
      <anchor>6ab4061075a08f7bd2f43d7e5eb77931</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlMserStats</name>
    <filename>struct__VlMserStats.html</filename>
    <member kind="variable">
      <type>int</type>
      <name>num_extremal</name>
      <anchorfile>struct__VlMserStats.html</anchorfile>
      <anchor>0b324968bd3bf9e0a5abd3bab9863c86</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>num_unstable</name>
      <anchorfile>struct__VlMserStats.html</anchorfile>
      <anchor>75a003f6e30cab05e0af92ff9a4d44a1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>num_abs_unstable</name>
      <anchorfile>struct__VlMserStats.html</anchorfile>
      <anchor>4a67a951b737343022c0b35dc4fd9aa1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>num_too_big</name>
      <anchorfile>struct__VlMserStats.html</anchorfile>
      <anchor>a543736bedbbee851a024214fea5b96e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>num_too_small</name>
      <anchorfile>struct__VlMserStats.html</anchorfile>
      <anchor>efbfe5f1905746df1fa156bdb05f26de</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>num_duplicates</name>
      <anchorfile>struct__VlMserStats.html</anchorfile>
      <anchor>6411ac36eb4bc981a28fd9a784cc7a44</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlPgmImage</name>
    <filename>struct__VlPgmImage.html</filename>
    <member kind="variable">
      <type>int</type>
      <name>width</name>
      <anchorfile>struct__VlPgmImage.html</anchorfile>
      <anchor>cefc89911cb45ea3ca09a439e6249072</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>height</name>
      <anchorfile>struct__VlPgmImage.html</anchorfile>
      <anchor>6a759d2567cd2621c203f95df9f86155</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>max_value</name>
      <anchorfile>struct__VlPgmImage.html</anchorfile>
      <anchor>3b0361fe17c95719a6d69209709cd2d8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_bool</type>
      <name>is_raw</name>
      <anchorfile>struct__VlPgmImage.html</anchorfile>
      <anchor>633e69493ed3d3978b85d94aabd6434c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlQS</name>
    <filename>struct__VlQS.html</filename>
    <member kind="variable">
      <type>vl_qs_type *</type>
      <name>image</name>
      <anchorfile>struct__VlQS.html</anchorfile>
      <anchor>196728c809c801edf185e3d6fd2832e1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>height</name>
      <anchorfile>struct__VlQS.html</anchorfile>
      <anchor>f4274222e9b478481051a62e7e0527f1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>width</name>
      <anchorfile>struct__VlQS.html</anchorfile>
      <anchor>cc79c68f5c929537252ea69fd60ecfc1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>channels</name>
      <anchorfile>struct__VlQS.html</anchorfile>
      <anchor>102525de1ed872c106c5e29736b454ae</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlSiftFilt</name>
    <filename>struct__VlSiftFilt.html</filename>
    <member kind="variable">
      <type>double</type>
      <name>sigman</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>05ce69e3f0d37f97bbca45b6a62b0b52</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>sigma0</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>26c296dd10f53b29b32e40d73294bfc9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>sigmak</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>1f91e8c9dbda42d613bf5d771328de7a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>dsigma0</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>2a563d98f52e5216ee16e54d0d49273a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>width</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>1906b63621988a3851416bfc87156536</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>height</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>f5c34894fe67875df1c9421584dce8b9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>O</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>e36d5a3c012a53484bbf7ef1a125e69e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>S</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>8531fa640678ec497e74d8fe4bfd18bd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>o_min</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>9abcca743ed9482df03ccd9703909378</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>s_min</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>3631bdd696add103f8ebfe76750e9228</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>s_max</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>51a63e5aa77dca58de4c025ff40f77ab</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>o_cur</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>659eceb11be00244e73533f80f4ef484</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_sift_pix *</type>
      <name>temp</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>966d1b620b0409d8a2ae5d23bc590d34</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_sift_pix *</type>
      <name>octave</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>cc115305bd36cdbf9fadcbed78b2639c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_sift_pix *</type>
      <name>dog</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>e4c71713d6f7c50aca4d8eb116a7d36b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>octave_width</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>388916e4c598f6e4467e141323cb0a44</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>octave_height</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>f1362c1385ac4e702fcf56b975ad9160</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VlSiftKeypoint *</type>
      <name>keys</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>c7faf5e26c50f14c32be754b6b5432fc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>nkeys</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>7e4bab1036ea1bda1dbc2f9afc802706</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>keys_res</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>30c797b88b552d10216a6d61d7eeb1de</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>peak_thresh</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>69ed17e70181ab091428d2f7bdc96dd4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>edge_thresh</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>4831ed8209553fc012d9ded817c5040b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>norm_thresh</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>4eda1df6592784e5c36298d09f77263f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>magnif</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>94e63c4c20be598af56de9cea2e9f93b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>windowSize</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>5540e0aab7df5e5abfb58d3d07af844b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>vl_sift_pix *</type>
      <name>grad</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>3dc6a5613163485ab9f0607b662af868</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>grad_o</name>
      <anchorfile>struct__VlSiftFilt.html</anchorfile>
      <anchor>dc7ee960ea6e3cebb08edeb0d33becad</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>_VlSiftKeypoint</name>
    <filename>struct__VlSiftKeypoint.html</filename>
    <member kind="variable">
      <type>int</type>
      <name>o</name>
      <anchorfile>struct__VlSiftKeypoint.html</anchorfile>
      <anchor>c50bd6df4c02dc9a8328182138bdfd96</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>ix</name>
      <anchorfile>struct__VlSiftKeypoint.html</anchorfile>
      <anchor>c1025b5469ccc9026a2c99f4b60d8585</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>iy</name>
      <anchorfile>struct__VlSiftKeypoint.html</anchorfile>
      <anchor>fc53ad2ca72bf603d97ee825443c3579</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>is</name>
      <anchorfile>struct__VlSiftKeypoint.html</anchorfile>
      <anchor>300976b838d8ebdab398dc99efd10c4a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>float</type>
      <name>x</name>
      <anchorfile>struct__VlSiftKeypoint.html</anchorfile>
      <anchor>d55f163faa167dd1531093df7b5ec0ea</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>float</type>
      <name>y</name>
      <anchorfile>struct__VlSiftKeypoint.html</anchorfile>
      <anchor>2c4c4950eed88f73d8a9bef4059cf460</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>float</type>
      <name>s</name>
      <anchorfile>struct__VlSiftKeypoint.html</anchorfile>
      <anchor>7f414c644da7a3dbe9191546a1eae1a3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>float</type>
      <name>sigma</name>
      <anchorfile>struct__VlSiftKeypoint.html</anchorfile>
      <anchor>9a19aaa4aae25c5d94fd275df6ecdb7c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>option</name>
    <filename>structoption.html</filename>
    <member kind="variable">
      <type>const char *</type>
      <name>name</name>
      <anchorfile>structoption.html</anchorfile>
      <anchor>dc503659d37af8017fb4b86d61c99086</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>has_arg</name>
      <anchorfile>structoption.html</anchorfile>
      <anchor>90d7ee9a51eea5c002682dbd0af149e4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int *</type>
      <name>flag</name>
      <anchorfile>structoption.html</anchorfile>
      <anchor>b366eea5fe7be25c1928328ba715e353</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>val</name>
      <anchorfile>structoption.html</anchorfile>
      <anchor>13bd155ec3b405d29c41ab8d0793be11</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>VlDsiftDescriptorGeometry_</name>
    <filename>structVlDsiftDescriptorGeometry__.html</filename>
    <member kind="variable">
      <type>int</type>
      <name>numBinT</name>
      <anchorfile>structVlDsiftDescriptorGeometry__.html</anchorfile>
      <anchor>6bf67165989bf30a87fbee9d8462158c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>numBinX</name>
      <anchorfile>structVlDsiftDescriptorGeometry__.html</anchorfile>
      <anchor>c5fc1f103b6a9beb06f6f44e430d9238</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>numBinY</name>
      <anchorfile>structVlDsiftDescriptorGeometry__.html</anchorfile>
      <anchor>4a3c033f775f651a2d5273f0986103f6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>binSizeX</name>
      <anchorfile>structVlDsiftDescriptorGeometry__.html</anchorfile>
      <anchor>2f7cebbca23740b47fd2a61e89a08316</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>binSizeY</name>
      <anchorfile>structVlDsiftDescriptorGeometry__.html</anchorfile>
      <anchor>7aa1b8189daa7c1f0d78f4b2fd6fec7a</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>VlDsiftFilter_</name>
    <filename>structVlDsiftFilter__.html</filename>
    <member kind="variable">
      <type>int</type>
      <name>imWidth</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>9c17b20313a2e026ad0347e079eae0cc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>imHeight</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>1b24a96a2f08d35c518823b2e712eac9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>stepX</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>48a9620bdbe44148b03b25bfff207994</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>stepY</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>3763db4060170d772e5dbed1814aedf8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>boundMinX</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>af0d13c59603eabdc4da09036c6bc794</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>boundMinY</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>dccef65af615830571b55a5fa570e15a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>boundMaxX</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>f4160b79a5b6892d22c00e237dcacb82</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>boundMaxY</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>b1fd9e095431c677ee20a5cced6446dc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VlDsiftDescriptorGeometry</type>
      <name>geom</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>f471593ab1bf9af6af3b4cbdb07df49c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>useFlatWindow</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>ef50c2849ad819baf47a735491001aae</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>windowSize</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>f0d0b7277d783caabf846b978a1dc0ce</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>numFrames</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>75c0f0e89e72e4fecc7bdf8aab99c67e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>descrSize</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>d31b90e972aa35ff4bd53b84d7e0ca4b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>VlDsiftKeypoint *</type>
      <name>frames</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>1dca3121c8bf6a60c00b7cbd11acdb13</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>float *</type>
      <name>descrs</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>aaa5dccac876f7ee3eea377c0fb8274d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>numBinAlloc</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>5a9044b43e4c5405a3d505b1ab00005f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>numFrameAlloc</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>d0e316ded788e562060a771616317aab</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>numGradAlloc</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>b936cfbcad3770a29d86f23395f12484</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>float **</type>
      <name>grads</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>62f9297243cd34387bc48d2d23afe8c0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>float *</type>
      <name>convTmp1</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>ace26bd1398a6f708602b634682c9bef</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>float *</type>
      <name>convTmp2</name>
      <anchorfile>structVlDsiftFilter__.html</anchorfile>
      <anchor>4ceb0ea652377cef8b811f58dcfe2799</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>VlDsiftKeypoint_</name>
    <filename>structVlDsiftKeypoint__.html</filename>
    <member kind="variable">
      <type>double</type>
      <name>x</name>
      <anchorfile>structVlDsiftKeypoint__.html</anchorfile>
      <anchor>e50979c322397703dc25ba0c722b6fd7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>y</name>
      <anchorfile>structVlDsiftKeypoint__.html</anchorfile>
      <anchor>10125676410606384f4dfb04c9e046a3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>s</name>
      <anchorfile>structVlDsiftKeypoint__.html</anchorfile>
      <anchor>7d16dcb8527894d51cbbf6f80fb2457a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>double</type>
      <name>norm</name>
      <anchorfile>structVlDsiftKeypoint__.html</anchorfile>
      <anchor>f55f2c905d9287b31e25b455bb89d5bd</anchor>
      <arglist></arglist>
    </member>
  </compound>
</tagfile>
