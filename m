Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2127F747
	for <sched-ext@lists.linux.dev>; Tue, 18 Nov 2025 05:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763444259; cv=none; b=gfAPImQlsMtcUPp7uIzIcle9aGneLyXwEAhb8RmrO6o5wfpu2LMEFXz1msfcTe8bjUASDOkXLQG7EjiEmdJGTc23bgDWT6xBrbfdFoqkkrKyEMgIGrAjRurN32x17WN5fz3Wt2nvYVHxMN+X5MKXJm9DKySjR28sZ2YMdmcTWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763444259; c=relaxed/simple;
	bh=n/cUmJDk0OKYBckf46z+2otpAC/4kOunSFCNjNugoPQ=;
	h=Message-ID:From:To:Subject:Date:MIME-Version; b=u/desvySvmez986C0RqjXJJM9kR3qtWsMlegAWKITDQzjHdjF6x0vQHMg1+/XLsL1mD7VxF1KLJ6SpVXQR7Nbdugd+r6RfQPzdRdq+JPWkpI7IKuDTn84ed4mCBidputV9PP4VZdbLfXewE7rbxSYDSr5FnEIw0keQtezzQL42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=sJSIMLAj; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="sJSIMLAj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763444247;
	bh=vFMVKfX9+Jfnn8VKl/qnwzHrjVniWxjNW6U63GD24j8=;
	h=From:To:Subject:Date;
	b=sJSIMLAjFUQYZxa33v9u9reX1I/yy1A02uiqxgT7R3uGAVLDA33rGxbbfL+bFku+m
	 jsexw5MLrssao78H/sEQGv7S0Y71Kr3KTBlSCtK4tqLpcsZzFFKQWL+2Z9cL8PMs6s
	 wxNNoJxytJsPkq6VxNIxlcyRJ4NicZwYuU4UdEEI=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 958B085D; Tue, 18 Nov 2025 13:37:24 +0800
X-QQ-mid: xmsmtpt1763444244txxnmh1hy
Message-ID: <tencent_67540C5FC5463910910C6E855AB3402FEB09@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XAhgI8NAjEOkRyVkWVg7Tdg+wVr3lf/Ap8MlTG7k3QOcs8zYdbw
	 y5SkGLuUaxwu+pEqcgWY4qp1hMuRfhLGL6tph5mcYzs++c7dFS7hEVfgNEePQzcK93QYFcECHXBv
	 GiFa94Yzf8hZmoW7c7QlV5OSVsbwpvMlZJoMdzq/pVtKsznANU1ki3AvF7oErCJV+B9er5y8L511
	 B+7Azi9fk2gb2Uq78KeaJ/74mLWQ8TFba6TyhNITY+ut8ZoMlDs0BM9kaAyQl24aH5uUfJA0G5uP
	 SG4uutYabaEn3/kYAfs8Ae5Z+eg9GutWHDx0cs6IaqOqTPU/Rz98kEynX613AkPLVsJJBHCrsIJK
	 /FSpOkTUVJIvBaXjptZO5V2ko/gbCVhIjs55k69G9mjTfb2uCBdYaPB1R6sZG3HPwiHn+IRdhJnc
	 sjR+RM2z/ErCxrEsGI5+UrCU50ycOMpCoNNubkqc5Yqo9Yr8AiRzAstS4qViXqaScRmhO+6kXp7o
	 unbNAV0pfEtWxBbNsbKU3Xgh6VJpR7sCX2sVyshp2yOmPmN9iekxLw00KTWmcqGfd7+jh3qG2OUG
	 Br1WrnyNtaXB3X/ZHCF/AoVr9wI7tR2YRxDTDNOYDJHUXU1KX+s2vt9BiJsXr+ke3hp48BquSxEt
	 ypwvBu+jjgBBzMFf9uyefe8UCnZ/XRRNbIq1xnmN1RxlOt0pl238rJbfs/xgovx+XC54FiJ1T/ko
	 kuc8E7F71EizRu68yAr6fwoitOPZAa8q8r7Y18TIrsr3pjfOcBa9z/v3q6Vefum2LSVHiCONwDTu
	 dUPFAvtrfZnzg+iyWueQT31aQkfLV19lvqm/cvoFVeKhDEd0CqyfmA6doDZCmB4Yd8Z+u9X37XBb
	 xAZyruJ64GaH2pzk6LPUdIWsm6wO3qOcfzT7n7TfXyiMUVLO5gGe4S8243ZWv+uXPzWIqZnusL1Y
	 xA5Q/QfG1S/mikR1wamX2xxhJQJRISYqQ8w5xsyqiEksYx8Q7Zr96V7VMetCyT2ibJOZTSLx60E6
	 KH963PHftOrJzkyfS/zMPoOqedtdMwSvMJ3RxQythIBNzzHLD2
X-QQ-XMRINFO: N+gupeqCsbX287b6dEawhJA=
From: Rong Tao <rtoax@foxmail.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Rong Tao <rongtao@cestc.cn>,
	yangsonghua <jluyangsonghua@gmail.com>,
	sched-ext@lists.linux.dev (open list:SCHEDULER - SCHED_EXT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] sched_ext: tools: Removing duplicate targets during non-cross compilation
Date: Tue, 18 Nov 2025 13:37:13 +0800
X-OQ-MSGID: <20251118053715.1748796-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

When cross-compilation is not used, BPFOBJ and HOST_BPFOBJ are identical
files, libbpf.a, and duplicate libbpf.a files should be removed.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/sched_ext/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index d68780e2e03d..0f2bffa3365a 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -133,6 +133,7 @@ $(MAKE_DIRS):
 	$(call msg,MKDIR,,$@)
 	$(Q)mkdir -p $@
 
+ifneq ($(CROSS_COMPILE),)
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)			\
 	   $(APIDIR)/linux/bpf.h						\
 	   | $(OBJ_DIR)/libbpf
@@ -141,6 +142,7 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)			\
 		    EXTRA_CFLAGS='-g -O0 -fPIC'					\
 		    LDFLAGS="$(LDFLAGS)"					\
 		    DESTDIR=$(OUTPUT_DIR) prefix= all install_headers
+endif
 
 $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		\
 	   $(APIDIR)/linux/bpf.h						\
-- 
2.51.1

