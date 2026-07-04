Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F942CCC5
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126466; cv=none; b=cq2Wqox9LO5ymuku5feLMaTK7svQWFak33wXSrQ4nUlUKELfkmhQnWjDzQcMCmRF/Bna9wDNN9ZfifwlyzQ4zbkApqHf+foqc0Fyj6inzxDjibfx1/kmh4gFpajswzRH+s58U5nHmop6YBrt+y6q8mLvTzjGNrBB4zWMZpGSAes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126466; c=relaxed/simple;
	bh=eYw4RvyIkgpq3mphQ5c9hy3rIqcLPfEXFyCbAqQEkVc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=XYVnsPFwXR0siYPgRoQi8RuU8n1YilzxzKN8yu9RX96Kw1YW3+YBl8yTQZSsVFqjSwqHByqSWIpg54HbHtw7khn3ILZGS5EkSyPQn1otsjGBOlyg/wtAwGv9ZPda4TR0tI97E1GGVs7UVwmoax/o5p8atwkdXfcFsGyduTxaCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5e3IWlS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5e3IWlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948D51F000E9;
	Sat,  4 Jul 2026 00:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126464;
	bh=eYw4RvyIkgpq3mphQ5c9hy3rIqcLPfEXFyCbAqQEkVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W5e3IWlSn5gVM6sfbbioEQm8BvvAXzkd2y/isB3qHxkljHKzb12aLXG7cv89xR4Yf
	 ri9gtURtlsokIKB9mM3l0VTeaRj5e9aM3NCWKEdbx2RSjep7keRH4THLi5QA+T5QCe
	 0myc5/ClajWich/k27vCs4pBZGgUUVbElanWf/ohtHrPt0oAj0uzrPXWDY7Z+f13LO
	 QQT/jDQb8qHymVt0BBXrn3EHXOIcypSEAMgB4eluYfUeHZdDhkExZp7GBeFXk7xyJ3
	 A4I4ptFgrJ7A258ql+snAGOk3vx/nBMrKq1nlzN8JpVvBHC25IPIiGddSPq/UADzbM
	 0VIM2Afm1becQ==
Date: Fri, 03 Jul 2026 14:54:23 -1000
Message-ID: <c19f18cc43921eda54972a0f88ee8550@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 03/32] sched_ext: Use READ_ONCE/WRITE_ONCE in cmask word ops and drop _RACY variants
In-Reply-To: <20260703083321.691901F000E9@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-4-tj@kernel.org> <20260703083321.691901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [Medium] Missing READ_ONCE() in cmask_word_op1 leaves
> scx_cmask_empty() and the boundary checks of scx_cmask_subset()
> vulnerable to data races.

v2 will apply READ_ONCE() to cmask_word_op1() as well - uniform marking
across the cmask word ops is the right call regardless of the current
callers.

> [Critical] The kernel trusts inline metadata (nr_cids, base) from BPF
> arena cmasks without bounds checking, allowing userspace or BPF to
> trigger massive out-of-bounds zeroing of kernel memory.

On scx_cmask_clear() trusting the inline header: it's pre-existing and
worth hardening. v2 will add a hardening patch that sources the memset
bound from kernel state rather than the arena-resident fields.

Thanks.
