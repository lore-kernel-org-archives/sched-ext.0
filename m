Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B6430BBA
	for <sched-ext@lists.linux.dev>; Tue,  3 Mar 2026 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548540; cv=none; b=rg71BtI1zVeVgdS6Ih4i673taguu7lGC8XCBciyNdEQqWSqE0YAXbDcTTWmCLzcFweCd8iTSRlkNMox9FSKyPg/5DG8GhTkUL5Nc4cEzxi+wsh2voMHp4FRVWxJamqW/yTp8gmZkDnL1Cc5m3BeEvscJuN5gKseHXTX8SZv0lgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548540; c=relaxed/simple;
	bh=HeiYvOGrpYd14ijPafjLzlaHQcy7c46Eu5YNBS2GNS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRuHCUv3nlK2eDS47fYYmb4Yrz2/CLjenPwDfHvhvijksjGn7AExZ9ot/V4o0faJjDRK4YbJXyEOg7gJlgz77nrOLG3USPSZHEgzodA1FPniPh38u4OkKJqxAApPrAII2CMohI7qCM2boRUBIGkq6EhdeeJus7m5B/yS35FIpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ0mb/Pn; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ0mb/Pn"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70f191313cso2261612a12.3
        for <sched-ext@lists.linux.dev>; Tue, 03 Mar 2026 06:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772548538; x=1773153338; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cwr9TWxB+IWof9S5wet3ZOfNWncZ8DLTtAA/wU8FZsU=;
        b=MJ0mb/PnlcarovXcIQYG6p0HNaXuqi1RVtLdh7dav3XzwjZ3YMOjzPU9gdfJ5yGB0P
         B9HwMOzy+2+reMVLiHpsXVFYA5gPy0LwyXhzg4Fb47Z/0KX7AfTY8S/IqSsiH5ui/fA0
         I9M68xmTryQ2SRy+2XC+4ZD9iRT9dxCrYwrTBNo9dKTZyg8ADhS1uvYpDcfJpvlrs6VH
         KCDKpCSobTjQwUjL879jVtTyDSbbZEHeIdkAZbVOJzgzYsNOBq9t7igGRgD7Eu3WHoZb
         aFUGZXVXupsxx4UX55rDnOYi6RZM2Spzcz0SG4OadF7ItV2Kdqr5WNygYU2pgJD5DDv3
         /OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772548538; x=1773153338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cwr9TWxB+IWof9S5wet3ZOfNWncZ8DLTtAA/wU8FZsU=;
        b=Qg2mdMga80KfHaYKZlcewr8/zm/hAyVbvDLwZcDtvpMBoNHRGhtWLDRryG9WyE10KC
         y8uy0r34iBREG2wfXoaMcpfvjI0kbv/TVLOFryHooPUMVxDysgqeowxlfTWrNwTGqLk5
         p8hnmz6PZRwz+bkZffk9Ieb3r/dF4TPhYJeGNt/ukWxlWEmRmovx+G1iXGvC1KE1ZG96
         Tnkoo/uQShiWjPwyUOJrsQ/XmcppIjQv2gGYs96NZ55qffIDyKTxxFbXuCmpEEo+6D9h
         Wa6NtHxwpnaPceFhUny85MFgnYXYACE2OUadYeg1Rhlel0ytC6Q2icyqs1WDIWG4F9K4
         S3fg==
X-Gm-Message-State: AOJu0YymgeqfB7tU8rNuaNrz+t5D2/nXHJF6v7F7cgnWn3uPNIy94Md3
	6h1BAbBRB7sjKax26WVqIWoxxvx5jCe8OGEABzRdlt1QIwH1O2+4gYQe14Qo9hXz
X-Gm-Gg: ATEYQzz9Vf+L2fomSOfW/qvzJUNivmviP0rxNUmBN12plEi2/KNsxrqJSvjLGXLHlQw
	xVzc/X0bhqcxxmaYfcUQ3SSOLaicVySNBgIM3UsjkEWuvCRJSMvUw2C11MVJHHyUoW6xHt5xufk
	M1oxIPcMvQHiDXP4Mj8BxCp73mc2faAo8HBXjy2s3Qf8WLOsTjrgGOhjMmZvOt4Su99asPVZT9W
	3T+fmKhHPJKP+aT7KmYm164SCxX6HLKTJWh2b3ksr3FmyEYMAPAG98NR8P9UVSHWqgAhd+5n33N
	4hPdr0dMVFzBPFCUe8tJT4Sr/cN/sPiDay6z5iB1bKpaBDRGDPWmCWiChr7sbUiCUTS75oG47Cb
	EVc+hGOYDfOBNfzYDui3y/WZ3AXy7sZb3X2BBAwNYywmY0+3IA+YzruB21GnF5hnDdKgvAnNnNF
	RppoMROz5ZxHILgRTYr2MFZSGUcOw7ZJOIbLssjvcU5YUUPfwJAjUrI8MThQ5BWA==
X-Received: by 2002:a17:903:37cc:b0:2ae:61db:7984 with SMTP id d9443c01a7336-2ae61db7cc5mr20066945ad.51.1772548537569;
        Tue, 03 Mar 2026 06:35:37 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:af56:6148:37d:1e5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae534088c4sm76847025ad.26.2026.03.03.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 06:35:37 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 0/1] sched_ext: Remove redundant css_put()
Date: Tue,  3 Mar 2026 22:35:29 +0800
Message-ID: <20260303143530.135968-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed a redundant css_put() call in the error path of
scx_cgroup_init() within ext.c.

According to the cgroup documentation, css_put() should only be
used to release a reference obtained via css_get() or
css_tryget_online().

The current iteration uses css_for_each_descendant_pre(), which
walks the cgroup hierarchy under cgroup_lock(). This iterator
does not implicitly acquire a reference on the yielded css
structures.

Since there is no preceding css_get() or css_tryget_online()
within the loop, calling css_put() when ops.cgroup_init() fails
appears to cause a refcount underflow. This could potentially
lead to a Use-After-Free (UAF) vulnerability.

I have tested this patch by building the kernel with `make -j` and
`CONFIG_EXT_GROUP_SCHED` enabled. However, I do not have specific
data or a reproducer to test if this error path triggers in a live
environment.

Could anyone clarify if this css_put() is indeed an unbalanced
refcount drop, or did I miss a reference acquisition somewhere?
I have attached a patch that removes the unbalanced call.

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (1):
  sched/ext: Remove redundant css_put()

 kernel/sched/ext.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.48.1

