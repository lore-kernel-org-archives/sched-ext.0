Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF6296BA2;
	Mon, 11 Aug 2025 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931175; cv=none; b=fWTbSuEPDYX+g4JDi9KnnUX4TEE0EFpkiZnyRh3sb1GgufBnB0i0sESij8PmyQmVyHIltIJ22MuVUgruR7DsTRRFnrt5d/jXGYN/zxRn8glWatnp27DB9Sd6/7SMGvZYj3ARt+87YUAtg230jut2j7qGyc/DwZPZ3pmS4MUDq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931175; c=relaxed/simple;
	bh=fR0j4ca+fyw4UvF4rZ/cJKtVYzot/62gJc48aAk6eNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4TLxG66r7jPaIDDKMeQil+rvJuRB5Fe+LjnccV6Mup2pz5mw0eGic9DrArz3qzm9vqMscIXY9seHOHrM0KBMhLjXxoMF+k2laVHg3q9vI+cEQIVMy9Puot2+vbCtg2Eq0c/LoN6L79i+EWKqRWbLr9SeAREmrJ6SNBIQCh6F9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+7ZSOMk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+7ZSOMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF84C4CEED;
	Mon, 11 Aug 2025 16:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754931175;
	bh=fR0j4ca+fyw4UvF4rZ/cJKtVYzot/62gJc48aAk6eNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+7ZSOMkiWbcUHCYomDzwYR0fwLNaLz0KIQy5WAuljMKgWF8lc7FvD2tukg1UU8jy
	 ypIU5wIgQ/eU/+WSmHJG/8Nk4zefq892O31wJ6nWoiAFbk9clke9+EQ5thHod3F2p7
	 SCa/NLHiP7zOQBEqk5BY56gPbncC2OXqDiO+ddX/bvn5JixIupNq38/ltnXmL9ng0C
	 7n1kMp02Q1gASvXD+lvXmqJinTlVlDGKeCV6lBthJiVV5/1JgqqZSoc6od8H/UdIu7
	 1jh04hisAPQjthX/wCpuqNuwwMazz43n0hGk5uVNi07e8UksDc/110azyXUA5faPL+
	 lESvqvslDEENQ==
Date: Mon, 11 Aug 2025 06:52:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Andrea Righi <arighi@nvidia.com>, void@manifault.com,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	changwoo@igalia.com, hodgesd@meta.com, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v3 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
Message-ID: <aJof5QVDR7x-TePI@slm.duckdns.org>
References: <20250805111036.130121-1-christian.loehle@arm.com>
 <20250805111036.130121-4-christian.loehle@arm.com>
 <aJebkj-neVJNKEJ4@slm.duckdns.org>
 <aJh6BWX7rYCNrzGu@gpd4>
 <cc68722b-75f8-4de8-bf83-0fc1518ad60c@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc68722b-75f8-4de8-bf83-0fc1518ad60c@arm.com>

Hello,

On Sun, Aug 10, 2025 at 11:18:52PM +0100, Christian Loehle wrote:
...
> > Yeah, this is not nice, but they would be still broken though, in PATCH 1/3
> > we force schedulers to check for NULL and, if they don't, the verifier
> > won't be happy, so this already breaks existing binaries.
> > 
> > Even if a scheduler performs the NULL check, this change might still cause
> > incorrect behaviors, which can be worse than triggering an error.

I'll revert that change. We shouldn't be introducing breaking changes
without grace period.

> > How about we introduce scx_bpf_locked_cpu_rq() and we still trigger an
> > error in scx_bpf_cpu_rq(), mentioning about the new locked kfunc and
> > scx_bpf_task_acquire_remote_curr()?
> 
> If we still trigger an error in scx_bpf_cpu_rq() what's the difference
> between scx_bpf_cpu_rq() and scx_bpf_cpu_rq_locked() then?
> Just the error message?

Let's add a warning to scx_bpf_cpu_rq() pointing to scx_bpf_cpu_rq_locked(),
update the schedulers, and drop scx_bpf_cpu_rq() in a couple releases.

Thanks.

-- 
tejun
