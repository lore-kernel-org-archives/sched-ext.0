Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721A33C7E07
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519428; cv=none; b=JeCTw9zMGPRsDAqLjISmaCBddl4c9P8YaMUL11dDtgGhSxnuTg8zdgTR9++/OaC0UVHUz8++NzrYRutR1CZS8CV1qMcFRGoRRIFABLQ7ualaDekVExEOhLLE2OBU5AIWArx3/7gynC7VyV4/XElEwTkRlsF0PjqEKuu+ri+bXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519428; c=relaxed/simple;
	bh=URKNOXUn2s5GqmtATW0jjXhBx3Xt4Nwx8I+0rmBrGAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFqsKE2bxDABvasNWhZ9LHhkWEL062Lb7aBgNN0oUnI/AeD10hz0P7q8MtGY+Zkodf/FsKGXtd1KqMDp6g7uLbZMd7dW2yrXM2xbzBk47jENhN/rOzEmD3b+zvxSyZOhg41z8fw+g/nNEgipILnJkaQ5bjgH2KoHBgESgMSJ+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=gnHBguLb; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="gnHBguLb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nH
	wElMpHBZahGiO1c8rV3mEvJmoJRvhrq1zz2veMKfA=; b=gnHBguLbGYdzZ5NpIz
	59DhyCkGpe3GWhg9J/vb/4K/P6d6cb2Rm+jNm9bFkOFIf1UZ7XfofER5B12VHG5z
	BY9gGWn16eO1dYtF6J3KqPKPenkKAaR0VmUx3qxqnw90jkZDQo+tFQ2Ak0vHe0Gr
	Vq6vxW5gn0Ob7AQZofSz2PRHQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDnL39kBMVpb5XpBw--.28030S2;
	Thu, 26 Mar 2026 18:03:17 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH] tools/sched_ext: avoid redefining SCX_ENQ_IMMED
Date: Thu, 26 Mar 2026 18:03:13 +0800
Message-ID: <20260326100313.338388-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgDnL39kBMVpb5XpBw--.28030S2
X-Coremail-Antispam: 1Uf129KBjvJXoWruw4fCw43urWUur1UWF47CFg_yoW8JF1xpa
	ykZFyUJF1aqrW7JaykZF48GFW7uan3Zr1xXry8u3y2yFZYq3W8tr4aqF4YkrW5Xr40yayx
	ZF92gry2vry2grJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVxRgUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqgXlXWnFBGWwVgAA38

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Newer kernels generate SCX_ENQ_IMMED from enums.autogen.bpf.h,
while compat.bpf.h still defines a fallback macro unconditionally.
Including both headers then triggers a macro redefinition warning
when building BPF schedulers.

warning: 'SCX_ENQ_IMMED' macro redefined [-Wmacro-redefined]

Fix it by defining the compat fallback only when HAVE_SCX_ENQ_IMMED
is absent.

Fixes: 98d709cba319 ("sched_ext: Implement SCX_ENQ_IMMED")
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 tools/sched_ext/include/scx/compat.bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 654b566bd94a..52e6fb9ea211 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -425,7 +425,9 @@ static inline void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags)
 /*
  * v7.1: %SCX_ENQ_IMMED.
  */
+#ifndef HAVE_SCX_ENQ_IMMED
 #define SCX_ENQ_IMMED	__COMPAT_ENUM_OR_ZERO(enum scx_enq_flags, SCX_ENQ_IMMED)
+#endif
 
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
-- 
2.43.0

