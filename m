Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D32D7DE9;
	Sat, 19 Sep 2026 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777737; cv=none; b=pLMxk1KDW9y51SqmvHG1VQr3z7FaZomNYSL2g4d+5uI8hExODie0E8K2ZS1PTU+GqLqPYVRouBz8aNAsPe+ClDC+02K5LXrOEb5Z9Kgmv9kw1nNRpHRm7yqbXHtYK0LWjpjsfXpaCpqsnTnzRKhFTsnQvSskt3dUPrK71pvEY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777737; c=relaxed/simple;
	bh=Nmn82MR463k7b2+mDKNQfB8h/RZcFumlnFlb8aHP4j8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=l29HTN9InRnFJ5LpdzqQ14O1j2GN7nsHkcHyZq/PGVjCh8DfJVAlc+gK64yOnkP1dsyON5k5qj+KrEuGY2wBLEg4ydtahhGkuqVAnlI4guEFIRYRwSF5Q6/5umyX9AJF2SIVATpe/LEop0RakpBe/SRgu4tcgvpSPK4UqcZGfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO6EbT/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO6EbT/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9473A1F000FF;
	Sat, 19 Sep 2026 00:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777735;
	bh=Nmn82MR463k7b2+mDKNQfB8h/RZcFumlnFlb8aHP4j8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NO6EbT/atUqyelYwyNQMtfPtiAae9DdkjeM3IpLxYELd4sb9u2o1lbMo8tqVJ4e8n
	 EboD66wZWCHWgOdQUg26q/pbw9sSi1iPIuWFHYosrF1D3WfVGGs/YsmUxU/SUM9tbN
	 qrkKkv93Q43ygtlpskgTH2BprS5WgITkV4r02ZQz7n+96tQRRktyPD9PWvfkTU5lKT
	 xFqdB/o1J7rwqnLsCqorfti0Dvk61QOqMJD8bTrp6Oq1Rw0HzQOfgS/bkrWSjIEoBp
	 5RzTYwXCH4HYUk8pJn2m5/o1JmBA+yrY5rRyeByG/xxmpP6qZyw3LGfZCZpiRN0ltF
	 eUzg8tD+NAjkA==
Date: Fri, 18 Sep 2026 14:28:54 -1000
Message-ID: <6e56532df8297554f3f76ad8748e84c9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Pass the initial cmask
 to cid-form ops.enable()
In-Reply-To: <aq2vjD_eTI3sMK91@gpd4>
References: <c8343c2e457508a6cd3fcab66b0823b6@kernel.org>
 <aq2vjD_eTI3sMK91@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Fri, Sep 18, 2026 at 11:39:24PM +0200, Andrea Righi wrote:
> Can we deliver the initial ops.set_cmask() before ops.set_weight()? Otherwise
> set_weight() can observe an empty or stale saved mask during the initial enable.
> This can matter if ops.set_weight() derives per-domain state from both the
> task's weight and its allowed cids.

Yeah, makes sense. Moved ahead of set_weight() in v3.

> Does this break existing cid-form scheduler that implements ops.enable()?
> If an existent scheduler moves the new prototype, does it load both with old and
> new kernels? In theory if the new args isn't used, LLVM should eliminate it, so
> existent BPF schedulers just need to use the new prototype and should be fine,
> but I haven't tested it.

The cid form is still considered unreleased, so compat isn't a concern there
yet and breaking an existing enable() is fine at this point. FWIW, I did test
it: a two-argument enable() that doesn't touch @args never reads the second
ctx slot and loads on the old kernel, one that reads it is rejected there
("func 'enable' doesn't have 3-th argument"), and an old one-argument
enable() loads fine on the new kernel.

> Can we also add a small selftest comparing the mask received by enable() with
> the immediately following set_cmask()? That would cover arena-pointer rebasing,
> mask contents, and callback ordering.

Added in v3.

Thanks.

--
tejun
