Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865935CB61;
	Mon, 23 Mar 2026 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774250601; cv=none; b=Al1X8uLkONHjX4r04+BML2CkYqeMiVyVgKrIAK8x2ywQ2gMq5oyF3kr8ehQ2bOtT4rkVbVNQ6D1vQmmCuzSM0oYhK0YvadLvL14WYWYgQimTxp2hqs03WFnrSgURO5L6VP0VdaYCgfnw2w1zVC5MHd79jGPmZodVrKK/866zna8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774250601; c=relaxed/simple;
	bh=FN3dcapTLOA6BQGQyjs8QskvXwBf7LeJc3c8I0EBRj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpwGWKcPXcneRrL4JzOo2+3CQYgHgC7GwvsX9osZJF9krfU8u6E93JGj92xXzS3c91ruGh2NU4tgl5CuGn813RfxO/v11S2S1VhWEzcxGJFFpp0YLqt6HknXDCH19hmj8K6o1MjtVFW5DeQ/EE3o2F+GbYFD08NvsYOufMdgoMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeWJ5+bY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeWJ5+bY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26A3C4CEF7;
	Mon, 23 Mar 2026 07:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774250600;
	bh=FN3dcapTLOA6BQGQyjs8QskvXwBf7LeJc3c8I0EBRj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WeWJ5+bYktbDYk1LubjwGBfHLkvu48w0LadVztCmfE4N5EcDeSPOaLFvlsAaV7IoC
	 KFkYqTgjaYPBUN+4ofpiuhPotjubU3N/X44uOuCx0cVaNeCp2SoXOYzPFkdkEUpm5v
	 lBfWDrdxCOkbBilefO/6HzSVm3CXfF8DhTvfwabgir63Z+s4zbYelUeZYh6QVt3H1L
	 H3NQ7zf6KzJ9ZuP1G8Dbipn6ikVvP19ZETujgFJhuXz+kwpx9nlydqHRlg0DEpBQNE
	 LFpoWqpAmVxPSxtq9hCr5WMyx7gngJbPIBUrxImr73tCGi0a3liEHt2RTUZ/9ymOoh
	 2HINt5VYHtFZw==
Date: Sun, 22 Mar 2026 21:23:19 -1000
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, peterz@infradead.org,
	mingo@redhat.com, shuah@kernel.org, zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add failure-path tests for
 sub-sched
Message-ID: <acDqZ1PTcksLXiom@slm.duckdns.org>
References: <20260323061832.2743315-1-suzhidao@xiaomi.com>
 <20260323061832.2743315-2-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323061832.2743315-2-suzhidao@xiaomi.com>

On Mon, Mar 23, 2026 at 02:18:32PM +0800, zhidao su wrote:
> Sub-sched error paths have historically been fragile: a cgroup
> double-put bug and an uninitialized return value were both found in
> the abort path but not caught by automated tests because only the
> happy path was covered.
> 
> Add three tests targeting specific failure scenarios:
> 
> 1. sub_sched_parent_reject: Tests the sub_attach rejection path.
>    A parent scheduler returning -EPERM forces the kernel to execute
>    the abort path (ext.c abort label), which must correctly clean up
>    partially-initialized tasks and SCX_TASK_SUB_INIT flags. This is
>    the path where commit 0c66b0da0064 ("sched_ext: Fix cgroup
>    double-put on sub-sched abort path") and commit e36bc38ebfac
>    ("sched_ext: Fix uninitialized ret in scx_alloc_and_add_sched()")
>    occurred.
> 
> 2. sub_sched_nesting: Tests cascading disable through a 3-level
>    scheduler hierarchy (root -> level1 -> level2). When schedulers
>    are detached in reverse order, drain_descendants() must recursively
>    wait for all children to complete their disable sequence without
>    deadlock or resource leaks.
> 
> 3. sub_sched_race: Tests concurrent race between parent disable and
>    child enable. A background thread destroys the parent link while
>    the main thread attaches the child, exercising synchronization
>    between scx_sub_enable_workfn() and the parent disable path.
> 
> All three tests create cgroups under /sys/fs/cgroup/ and are verified
> to pass on a kernel with sub-sched support enabled.

Let's hold off on sub-sched tests for now. It's a bit too early.

Thanks.

-- 
tejun
