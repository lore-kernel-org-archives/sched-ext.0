Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9251F0E34;
	Thu, 26 Mar 2026 02:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774493111; cv=none; b=cOCQ9CyiBRmgLySgoxc54eLqWuk1a+VwWHJk/i6af7kcFKhpNrgr6UGEem0GT/RqdEAgswdpYTqH/XtTbqENxXvhfedF9eC1SIQmsQAeLO+Tcs/yjy2u8fp+IqBI8+/CcvIXLc6Xi8f6QMy7NMQVn/DIhg7A0ZKfpu7ySDgk16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774493111; c=relaxed/simple;
	bh=ukZ2iFZXkdeB0gKKRj1v94A1hiIm2f4U9rjYWOkSQNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mw+/kCleE8g2vBzi6ag/DZ7gtwY8JVb/7UH8P8W5vMsXrxe6dT4WjGFWS8VGg9gnXSpMDUwfcJKD5Mln1q1+1Dg4IFovQwINNqprhn+2Q/IEepdE1HJMv+JmwcRVNHT/EjToEVLpZs6mbdboDm6jZ5WRLSvRED1o8r9cyL9W5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih0+s23K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih0+s23K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A44DC4CEF7;
	Thu, 26 Mar 2026 02:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774493111;
	bh=ukZ2iFZXkdeB0gKKRj1v94A1hiIm2f4U9rjYWOkSQNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ih0+s23K8S+9Ony6YKAv+x5mmnF/Aj+4O67wSBh7CTneGKdXqIQ3TAyClHi5AGLwO
	 kPFNpqebbjzqBkRk5VVo5y7cCgBuVn25/lQCuF2LiFKicj62sC3pHrnlEr19Daqsh1
	 5Ml3JFwqKYtWCvRE1eZt2Myy4P7b8q02oQemdQ6ReXX+LGYgyxpl+IPWLYtRqBXuq3
	 BhNOi7TaUtOHB84QCfr1f8hNBA+VDyFOn+7Dh/WlJOERycZ+Gaw5micjp4+LjK3DLO
	 UJ91EIE9JNSrTEuR2WQKa6VYLMRE9kszd+CVaI25bzjBQvnY9y4fxyoeWM3ABKP7PU
	 rXfrXcpbwKvWw==
Date: Wed, 25 Mar 2026 16:45:10 -1000
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	peterz@infradead.org, mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH 1/3] sched_ext: fix NULL deref in bpf_scx_unreg() due to
 ops->priv race
Message-ID: <acSdtkMeCWBVuIOg@slm.duckdns.org>
References: <20260326022827.3826287-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326022827.3826287-1-suzhidao@xiaomi.com>

On Thu, Mar 26, 2026 at 10:28:25AM +0800, zhidao su wrote:
> The reload_loop selftest triggers a KASAN null-ptr-deref at
> scx_claim_exit+0x83 when two threads concurrently attach and
> destroy BPF schedulers using the same ops map.
> 
> The race occurs between bpf_scx_unreg() and a concurrent reg():
> 
> 1. Thread A's bpf_scx_unreg() calls scx_disable() then
>    kthread_flush_work(), which blocks until disable completes
>    and transitions state back to SCX_DISABLED.
> 
> 2. With state SCX_DISABLED, a concurrent reg() allocates a
>    new sch_B and sets ops->priv = sch_B under scx_enable_mutex.
> 
> 3. Thread A's bpf_scx_unreg() then executes
>    RCU_INIT_POINTER(ops->priv, NULL), overwriting sch_B.
> 
> 4. When Thread B's link is destroyed, bpf_scx_unreg() reads
>    ops->priv == NULL and passes it to scx_disable(), which
>    calls scx_claim_exit(NULL), crashing at NULL+0x310.
> 
> Fix by adding a NULL guard for the case where ops->priv was
> never set, and by acquiring scx_enable_mutex before clearing
> ops->priv so that the check-and-clear is atomic with respect
> to reg() which also sets ops->priv under scx_enable_mutex.

Can you reproduce this? How do you trigger enable on the same ops that has
already been enabled?

Thanks.

-- 
tejun
