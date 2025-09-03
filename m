Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0C22E3FA;
	Wed,  3 Sep 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914935; cv=none; b=E4ivgUXuFWrV4CElJaomganXeMdgbDH6SR0AgpW1rgI2HCBZ8T6YsoZQr+nOo/EEwdfHDwxP0qy3Rduia97iBZciLocteZdmCdp1qrZv1mZp6U/l1At+vqx4D4JJudJshUcya40QDCXx/S6rK2ei6g9cjuWc3BkrthvgnWgIeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914935; c=relaxed/simple;
	bh=BMf5mZ5PkwD5AbMN+HBAC4jxkqriM7mMi3NxWoJDY5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhdG7nQYUs4hLXkAcdZyN/hBBAdJOtMVR9pKqcttb/z2VmNoK9E1LkiswUxR0JgT4IHBbr+Fk3mf3BlehuDWe89PU0vxGvf1FXcoKQDo29pcd6omcT4tCAowkxm1ZAOqVCMdkIcVzzuI7LyOMH9SKBfETZcfLfJvNxw2NIpm/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkiNJeeE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkiNJeeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF469C4CEE7;
	Wed,  3 Sep 2025 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756914934;
	bh=BMf5mZ5PkwD5AbMN+HBAC4jxkqriM7mMi3NxWoJDY5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkiNJeeET+gWp+djcXvaWkEBLzDBNLG50U3PEqesGwEfq4RVEsG7iQpoZdGPUbiZH
	 02AlUqlHdP5RW4C7AKAg7RIKi9nrcZY9bqIA5PWIs0CUb8FdMN6sRJLDDbX7EI96E2
	 fhw5J7qdXWpwvbA0g3MoxnT90Sscp9E1rDUKuU520VaJc556Doy4Hcq+Ea+EflaRWX
	 vXz+IctSLWoGPoIG6DrerUJgjE9gafBZsrPP8JSyWCqSwUVyhDEm5E8hQQLqtXZD7+
	 i8BYzE+vm8l34aeVZALak1MnYKQVEx29J/0S2x06NkQaavoRDYOxB/sFGymYcuZi2y
	 fAYhdiFXJS+Ng==
Date: Wed, 3 Sep 2025 05:55:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: arighi@nvidia.com, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org, jake@hillion.co.uk
Subject: Re: [PATCH v5 2/3] sched_ext: Introduce scx_bpf_remote_curr()
Message-ID: <aLhk9Ugqu4ExvQNK@slm.duckdns.org>
References: <20250901132605.2282650-1-christian.loehle@arm.com>
 <20250901132605.2282650-4-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901132605.2282650-4-christian.loehle@arm.com>

Hello,

On Mon, Sep 01, 2025 at 02:26:03PM +0100, Christian Loehle wrote:
> +/**
> + * scx_bpf_remote_curr - Return remote CPU's curr task
> + * @cpu: CPU of interest
> + *
> + * Callers must hold RCU read lock (KF_RCU).
> + */
> +__bpf_kfunc struct task_struct *scx_bpf_remote_curr(s32 cpu)

And name this scx_bpf_cpu_curr().

Thanks.

-- 
tejun
