Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D54A200C2;
	Tue,  2 Dec 2025 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764718063; cv=none; b=Qy3yZKRZ3EsMvoVqK1yCXsekAj93/IfTdZxVm8q3jiJj2cTYfKbp7ltoNje/YpQmRqiAk8MzTofUhTKQjYcTXL8ahVjIQBrmkxERDbOivDeqa7Lt3OVbpnbTptdSdJFiK2zP3lgCgRgDpi3vqHBCQ43TYMirElTIW/F8Oedc1pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764718063; c=relaxed/simple;
	bh=O/U11dN/+NbSiRqMPD4eOF9bGBd9MKuMeD1JmV1T8/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gALCAVeryFIc3vjRcOFz/u4N2KOMBNSviQ4NVZZWSIrZPzkcKx1/YLTQgbppXlkDXaUP3ly7kjnYlmUgoemhKP/BYKzfJyYte6ew8ezYeNO2OJZvjc/ErsqXz1LwlNXgnrn5JT4LhAc8Ze44oOyBcpAzFeQcc92r6Bw/rjQO7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bs3ebSes; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bs3ebSes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4403C4CEF1;
	Tue,  2 Dec 2025 23:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764718062;
	bh=O/U11dN/+NbSiRqMPD4eOF9bGBd9MKuMeD1JmV1T8/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bs3ebSesxryK5YHPBS8dzCyYWCeJW8fMBssfWf1rIRTXcj0xCmEbBy3jpcdNecSsu
	 nbsicNKb9L9oICMYvbd87QZidsPom3pKiyKs5B6M8bqbLMcGckN8kEZMlYrYno5EMd
	 zLigk1tBRVpi4+d8VKLa502EXQ3we9h7QvVNyqh8czvb/6MxMVrirBCZ5loSxXo+pZ
	 lhZqufU3JqQ1nQuwczKOlZEyv5luwf3jEMGuu1IbXnPcuvUoLppBSjI9laEZVMrPEf
	 tIP1kxNC9BShw/Kg054xZn7j25toLX68WsVJiK+eidTOEy7DNhB30owCpjv6Umsc2v
	 MLh7mLlpA3CqQ==
Date: Tue, 2 Dec 2025 13:27:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev
Subject: Re: [PATCH 5/5] sched: Rework sched_class::wakeup_preempt() and
 rq_modified_*()
Message-ID: <aS917UwBI20pBOQe@slm.duckdns.org>
References: <20251127153943.696191429@infradead.org>
 <20251127154725.901391274@infradead.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127154725.901391274@infradead.org>

Hello,

On Thu, Nov 27, 2025 at 04:39:48PM +0100, Peter Zijlstra wrote:
> @@ -2174,10 +2172,14 @@ void wakeup_preempt(struct rq *rq, struc
>  {
>  	struct task_struct *donor = rq->donor;
>  
> -	if (p->sched_class == donor->sched_class)
> -		donor->sched_class->wakeup_preempt(rq, p, flags);
> -	else if (sched_class_above(p->sched_class, donor->sched_class))
> +	if (p->sched_class == rq->next_class) {
> +		rq->next_class->wakeup_preempt(rq, p, flags);
> +
> +	} else if (sched_class_above(p->sched_class, rq->next_class)) {
> +		rq->next_class->wakeup_preempt(rq, p, flags);
>  		resched_curr(rq);
> +		rq->next_class = p->sched_class;
> +	}

I wonder whether this is a bit subtle. Wouldn't it be clearer to add a
separate method which takes an explicit next_class argument for the second
case?

Thanks.

-- 
tejun
