Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3B334C12;
	Mon, 10 Nov 2025 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811807; cv=none; b=uVIj/vAAXuqNvAUiQHc/jF+UYqWkNI5axRwlG0VWybDF2XIjUT6feHeQMhko4PVXPDGp5IWvcaO31r8PtI8fzarjR71NIgojq3g54caK2ykR8I+aRbzJFIDGGiUlJcbKhT4hVRmSQ5ttCmWylXdA/NDZTW4fGJFxGYYg3dLtDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811807; c=relaxed/simple;
	bh=wKwBoxlGJ7IiZ3AhA0sbPBUJSOOgxRzq7UPK1oKPULQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wy6pZVLFvlfSqlzTAIq5P75AL/AEON92kGfWANYv44W4s7PTz7MyerHia8grE2uDdbKjTsRLMXtCqWv2E1QV1eAOpidHSjizmL9L3MwBwboL+dr7tAKRoJQM42omZ+h2aWgBNsKFGoGYlzrbXLZEHG0pXEpAKhnec4APMHTWHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muuAoYXo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muuAoYXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73490C113D0;
	Mon, 10 Nov 2025 21:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762811806;
	bh=wKwBoxlGJ7IiZ3AhA0sbPBUJSOOgxRzq7UPK1oKPULQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=muuAoYXoN1PNF98NtfL99HssRDjGrBPnhGoiLpxmDEfrsnrvKnq2aLM8jyAnjlQe3
	 kya4KYsMwRijUTQY4NS/UzzpIvbG/BuCQUaNhSMbxsoeL8/FvYPpfujSA7iwgnTr2R
	 uSpAMEoaQYXgcaPWpPiO2ONuki55d3DXd788hRt1Nzo1FntLB2y9fTH2lRWInmpACd
	 6W6KP7nTz0zn1iGQUUMyugZ2dvyKraa26vubWEy1OYTi+f5syd6ql/E2Mtps7Eaiw6
	 kOQjH8SzjVfYIBlYlmxG7bhosf2qMXYHuWgPY5TpoDXrD4AY5NNz51crUOrSIUDXdp
	 rMwyOPfLKa3pA==
Date: Mon, 10 Nov 2025 11:56:45 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] sched_ext: Don't set ddsp_dsq_id during
 select_cpu in bypass mode
Message-ID: <aRJfnf7zuMvFJIJZ@slm.duckdns.org>
References: <20251110205636.405592-1-tj@kernel.org>
 <20251110205636.405592-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110205636.405592-2-tj@kernel.org>

On Mon, Nov 10, 2025 at 10:56:23AM -1000, Tejun Heo wrote:
> @@ -2521,12 +2521,8 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
>  		s32 cpu;
>  
>  		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, NULL, 0);
> -		if (cpu >= 0) {
> -			refill_task_slice_dfl(sch, p);
> -			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
> -		} else {
> +		if (cpu < 0)
>  			cpu = prev_cpu;
> -		}

This isn't correct as local dispatch needs to happen when bypass is not
enabled and select_cpu() is not implemented. I'm dropping this patch for
now. The rest of the series applies fine and this doesn't really make any
meaningful difference.

Thanks.

-- 
tejun
