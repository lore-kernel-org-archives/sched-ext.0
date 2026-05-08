Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568CB3242D8
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266266; cv=none; b=NI82a6o8T3p8UdMB11rUq4nx9qHZCgx4cm5b5cFtKQp9DVN5iexjBmgGsOdt1DIcrgSvd/C9q1MDT8fxSmbTX3MulW7JcbuDXDzRCY4dmDxRFSQE9fEA0KU1lEsUawlHQgeN2np53FR9XnYyxX4BeeTA5Vtu26qSFt97SlOzRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266266; c=relaxed/simple;
	bh=MycTsNeId2i+KXh0m9Q4By7ZX9vdWJ7+Ux/wfz0XmOc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=LYpxmlT5ahTotd+8Q7g1JCDi2G0Fz9LCmvoa1/fIubCfotzUoUb4IZMArf8ZQ70KFPcDkJYLY2xVh0wdmNSizVlVssOrIgaxGfqfCfAbCqK7B4wFo+UA1XtGrkYzPz/xAmKaFYRd5IqA3bGL+eSJOUEinRi+IC15g8ix90X0Ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2Bw1fCd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2Bw1fCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB056C2BCB0;
	Fri,  8 May 2026 18:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778266265;
	bh=MycTsNeId2i+KXh0m9Q4By7ZX9vdWJ7+Ux/wfz0XmOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o2Bw1fCd3YRf3BEST+n/hPIQ0w3uU2pBM577X/tQDiIUTKzw/QfYB8HM9Vlg5f+Q0
	 qqceJS87kqwT1rSJcdPrx1A1gqXNblYmtcS17HbpEWrlh/ImsTt0auvmpCjnYPUzTm
	 J6CHHc8I/57vLoy4DY7ab5X/fs/zuTFUP/6O23U+VxxtYiCLiyKEmb1fBOGkW2OGqZ
	 gf28I8clXslnqlCKUYnyputrJcrO+YkXxicytVpicd5p6U9NnGxzGihX1lfdGgV2/3
	 lTXh8hzH52zrHCQX3qlMEGEqP31muap7HhHzeStNXezH5vEcdU+T/D8qCC7azgPf1a
	 yOlYDfqKCvK/g==
Date: Fri, 08 May 2026 08:51:04 -1000
Message-ID: <940c9ebdfaf50745dc5a310e3942b2bc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.2 0/2] sched_ext: Add cookie API for
 early qseq capture
In-Reply-To: <20260506160412.522199-1-yphbchou0911@gmail.com>
References: <20260506160412.522199-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Cheng-Yang.

The cookie/qseq vocabulary leaks the implementation. The API is
really a dispatch transaction where commit fails if the task is no
longer ours to dispatch (dequeued, or claimed by someone else).
Naming along those lines would describe what the API does, e.g.:

  scx_bpf_dsq_insert_begin(p)              -> u64 cookie
  scx_bpf_dsq_insert_commit(p, dsq_id, enq_flags, cookie)

The internal scx_dsq_insert_commit() helper would need a rename.
The kdoc can then describe the transaction directly without
referring to qseq or ops_state.

For the selftest: the BPF program calls insert from ops.enqueue(),
which goes through mark_direct_dispatch() and never stages an entry
in the dispatch buffer. The cookie is silently ignored. The test
would still pass if patch 1/2 stored 0 in place of the cookie. To
actually exercise the race-detection window, the insert needs to
happen from ops.dispatch() with something invalidating the task in
between (e.g. an affinity flip).

Thanks.

--
tejun
