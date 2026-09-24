Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B342BE93;
	Thu, 24 Sep 2026 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284590; cv=none; b=m+i6QQzqhiGb5y8K3+7WpJIQuciAy5qyLvimKyLgs7CE+kiEu/Ja1agW3k1SzfOP5CMIfgZcvtWKOUCrOpTlYJ61bOnJKqiywB7eYKxtw461+VQKci4OuFhvDy8dd31nWxm4GBNMt44HpJll0YK3LcQYggxEIePzESRxrHLkxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284590; c=relaxed/simple;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=tqlqzknrse/dwSMILjSN/uzaSb2Z869NFc0F222l9QDhLWci5Gkez+azUP5M4jBZ2KzVhPwR8dw0ZPGE8eM5ixzVVYQHHxp2Z8E5ewgLwHTAEqXhf7pHfIEAo62XBBiP3t+ukElZt0MYXwG+LzAhtDvr4yonhcdLzdSAAsvNaVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxajmyTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxajmyTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196E51F000FF;
	Thu, 24 Sep 2026 21:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790284587;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hxajmyTag/e4qWEL+GpmbXvx2p1E3XLeiuGAUHYAKe4vVyLVdGYqawMmuDtSLtE2+
	 CueJwaBq8nBR2rqhlr/3vVGySIa0mGLz17IXNdvp4FxFDTuVKN2eerP2+Asm1K0QaK
	 T+EhPkX5rPXS5faZ8wCI9FU6r9rANyrBkNXYEARowUQ6aCkdEXSdNCF+77o/FuPGv6
	 cwRZPVDsU1UX9O1cR/9SIguqC5vzrthb9qH56rFzqRXtzOfFzrERjB7K7NV14oB5NL
	 Zbv5pQs7jUEKcOGVOREgbT5Fpn6x02dfiHwVDhmT4Uud23/sdqkjQClPg0yTPFNCJb
	 Q9jXpvF+ffLng==
Date: Thu, 24 Sep 2026 11:16:26 -1000
Message-ID: <186976febe6753fa0105d144d8d7e59b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	david.dai@linux.dev,
	dietmar.eggemann@arm.com,
	emil@etsalapatis.com,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	mgorman@suse.de,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com
Subject: Re: [PATCH] sched_ext: Test scx_has_subs() inline before calling
 sub-sched hooks
In-Reply-To: <20260924202711.4042339-1-usama.arif@linux.dev>
References: <20260924202711.4042339-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.4.

Thanks.

--
tejun
