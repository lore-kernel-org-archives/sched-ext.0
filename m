Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB8367B7E;
	Fri, 24 Jul 2026 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920071; cv=none; b=PGDynQGmzhi2CXNDyKUHp3o8OnvvpiflQ1LckuLhOw7ezNe19IHYFQ66oxKD56z+GmtwC2pqzeu5NV4vKhZRN4IS5kSB5wYJzrxyj4ke3hK0SDQqT97EGmqcGqXwDPOp/1ioIWM3p9TAygjUE3rYJIQFcV4wWE7bKRCWkrO/2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920071; c=relaxed/simple;
	bh=E+QueYGwfixlDVZ/ecdI77df+89jSuP8asTRKU6wEKc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qmZPGE9Xa19EuJgodAdZSsURRsDQrmc3ioQqBfjldj7buf7JW3wbs4s6C4QWq/GjHGdEemTdVJow/S0SnMQa1Ql/Nib9dxvYMft+7CtH1pp9kgu7Ngs3syWSCQ2LqFUmOk6I2Z+K7ffWtAbDDryYBGI2OszDoKXtcAZcq+tHxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5AkyLal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5AkyLal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67AF1F000E9;
	Fri, 24 Jul 2026 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784920070;
	bh=E+QueYGwfixlDVZ/ecdI77df+89jSuP8asTRKU6wEKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c5AkyLalgssx/UUcuYSXfd2NcHrBs9RDz4TTewAY8BfPs+uCndCc4ZnOYnJwYG5Q2
	 Fd91jHhqus/lUzb2N9EdPtq47/GSVxdtH/pFyuRuVJHuKInPTxOky/Lk60f8Q/cMi0
	 ZZaeHjjGVkQEfQoJNcEG/IRKmEjEvXQep15ulQvqtwNsYGtsdy2zj52gQtxKDekmqH
	 QmihnL84Vi+v5krIPgprxNgZGp0wRVR9qAzuQyfaeGfQnLU8upRiKcOJBukMWSAlmD
	 PgNZ6jzFEMWB7ohKG3O33KRpNKhFlzK7s5euPCv+P5OCUpLqWeIU38IaCICA7o4Apv
	 DyxMe0DV8xO5A==
Date: Fri, 24 Jul 2026 09:07:49 -1000
Message-ID: <ab7fd0a02dcef6bb60ffee9bb0c1f8ba@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH 5/5] sched_ext: Gate scx_bpf_cidperf_set() behind a new SCX_CAP_PERF
In-Reply-To: <20260724184605.EB6641F01559@smtp.kernel.org>
References: <20260724182125.985061-6-tj@kernel.org> <20260724184605.EB6641F01559@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Fri, Jul 24, 2026 at 06:46:05PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does unconditionally passing SCX_CAP_PERF break backward compatibility on
> older kernels?
>
> If scx_qmap is loaded on a pre-gate kernel where SCX_CAP_PERF is not part of
> __SCX_CAP_ALL, won't the kernel's scx_bpf_sub_grant() and scx_bpf_sub_revoke()
> reject the unknown cap bit?

It would, but that's fine. The sub-scheduler caps interface is still
going through initial development and there is no cross-version
compatibility commitment for it yet. The in-tree schedulers track the
in-tree kernel for these interfaces.

Thanks.

--
tejun
