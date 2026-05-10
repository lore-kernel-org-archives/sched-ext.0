Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E637DE97
	for <sched-ext@lists.linux.dev>; Sun, 10 May 2026 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421981; cv=none; b=XYZFIw/xH6V0hkZ62E7C5XwLfrUw85wn19M3ygeZGAqsJ2xd0z3dkig7INghV8CC3uqEDju/rrHEDtxgdr4hMFhYqvDbEQL3IotGH4fkRYIJAcC42vvrv6bef6UuCY5Zz8jy+sfF6+cm2mDkfWjEJslNoMJgR4naJT8DS03X9p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421981; c=relaxed/simple;
	bh=78mmU3w9b1cqPP+6hrDK5ZOrU4NTVjWEoB237KaxYCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1c1sOVz7ed/AzuEfQlScuQz0SlAnYJCSNHBniPo7xUKLAR3sTR0h2mx0Gqf0fjZnU/+vjIWEcws/3QnmnYjqlkdUMqOPC3eQr+hyYFCKXIq6laHqXt2g68YaGyJNE855vz9ZKqdZLATLwo1a7FAChgMK4OG9Up24Bw2bUUxl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd3BF741; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd3BF741"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169F6C2BCC9;
	Sun, 10 May 2026 14:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778421981;
	bh=78mmU3w9b1cqPP+6hrDK5ZOrU4NTVjWEoB237KaxYCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dd3BF741C8OsqhkKPL+iN/D882hpsyge0eL6OAo2DGYyRaXafn7DlkVVIY8aeARt6
	 vW2AjbuZlELEELpGcJRV1sITlI8K7gtKBgA9+td00cmudaVxb/Zw7WYUNqIWZASzQh
	 s6KevtHfcgdgoJQuthAJRwZTv/636wwnFyt6/OMj2BSYpt8XZ1VXK7KP+ujt4gjPp8
	 60N7YdJ+0VdqjrNKW/VthPP8O6+wWL9B/eFsANcWklStbCj/6CIfQNbg3ekGYRNid6
	 4xk7AW+0klNumRT5eDlaembfPEvTq1RXvh/xI4MI1jYm0onBOwPSxJtnoszpn5BIDE
	 L1vLh0FjKd7HQ==
Date: Sun, 10 May 2026 04:06:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 1/2] sched_ext: Add dispatch transaction API
Message-ID: <agCQ28NVEIaQDHPP@slm.duckdns.org>
References: <20260509191223.168648-1-yphbchou0911@gmail.com>
 <20260509191223.168648-2-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509191223.168648-2-yphbchou0911@gmail.com>

On Sun, May 10, 2026 at 03:11:56AM +0800, Cheng-Yang Chou wrote:
> -static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
> -				  u64 dsq_id, u64 enq_flags)
> +static void scx_dsq_insert_buf(struct scx_sched *sch, struct task_struct *p,
> +			       u64 dsq_id, u64 enq_flags, unsigned long qseq)

Please don't mix rename and functional changes in the same patch. Can we do
scx_dsq_insert_stage() instead?

> +/**
> + * scx_bpf_dsq_insert_commit - Commit a dispatch transaction
> + * @p: task_struct to insert
> + * @dsq_id: DSQ to insert into
> + * @enq_flags: SCX_ENQ_*
> + * @token: token from scx_bpf_dsq_insert_begin()
> + * @aux: implicit BPF argument
> + *
> + * Like scx_bpf_dsq_insert() with slice=0, but commits a dispatch transaction
> + * begun with scx_bpf_dsq_insert_begin(). If @p was dequeued or claimed
> + * between begin and commit, the dispatch is silently discarded. Use
> + * scx_bpf_task_set_slice() to set a non-default slice.
> + *
> + * Returns %true if the entry was buffered for dispatch, %false on preamble
> + * failure (e.g. @p is not owned by this scheduler). Note: stale token
> + * detection fires asynchronously in finish_dispatch() after ops.dispatch()
> + * returns. A %true return does not guarantee the task was actually dispatched.
> + */

I think this needs more detailed documentation. It's difficult to tell what
it provides and why one would want to use it from the above and it's a
pretty subtle thing.

Thanks.

-- 
tejun
