Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFFF31282F
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918460; cv=none; b=SzJExGSH0ZHX4iQpw4n7HSXs/F9SR6q81tlq4BNYCTO9hYp2xhenzByudZvjeqOm3oxEWZ/IuRIZYADJbYphaywEb68wHZDJqFoVVDcpEGkjwAELzqn0APSgv4i81LuF2aCeg3JP3rTx2rM1omPFxo3RE5njAjgPm6Qi6kqnx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918460; c=relaxed/simple;
	bh=ZsEn5rxnGSt7tMnPzSsd3tXD8/8NEsfrgnLAUBa+wYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFJFs6u1CniEqvb5u2c7EPTx0vZUB37AOKhICXj7fVGWiOHkGekqLAMa2gA+oth8wd2WKQ3bncujviLlmA0YbptYi/jvDAvOUPRCE/wcDSrMyH3ummN3mKrC3nFco1w0nFvxQd7hVgX/EqJVR+5VBNjsYW4yIDRpDjHoGR2tqQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft6y76mv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft6y76mv"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so4132694a91.2
        for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 21:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776918458; x=1777523258; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pqu52UQVqmdz5XF97idtZH2dglQzs8pm/EDe81CVzZM=;
        b=Ft6y76mvfzHfIRBC5fbgX1DQw8EiCdfNWFxckorHiq9qzFF9jdLnjmw4PjQnZFSRar
         SqrLuXH+jhy/SiL/SaWOxhTxlBmOuGmhYW0yoZlaDcMcbz4hZX/OjL1bCvIQfAGAm1Sy
         9r6sAyf6aXNnZceRexVSzE2kkn6sh1sInoULm+KwttS0FcrRmlsgxSDGih32Rv6hlVrQ
         TdCpakyJjJBiPkXZOChsV8J/sbua0k7jbJGic+fv0f3+J1kYaMg7WYbLZRah0TUkm5mr
         UFROSsDlDOV2oLVmqNF0nxVeuQl/6R+vBCYC26bY7DlaHqqP8X61UMJs/WcRwuoSGSOT
         41pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776918458; x=1777523258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pqu52UQVqmdz5XF97idtZH2dglQzs8pm/EDe81CVzZM=;
        b=Pz0/rRsB+1QPkZfpA+wnRRTTVn/on6xk6n11yFhF3+blQPzh4eXO5CTzYKD/Pr8eSN
         j4cJiatmcKsOsqHsdA+xgvxRgacF2PXHuf03zUSTfhAXnUrMDX2aXV0g5DdPjJU9aHmA
         f0Pqojlh5Ob23PMOYOkVGdKNtbhmV006i6lg+D4abJdLKH7dmLHIvU17Q+ieLLIeaapr
         RdMMRtNb1ABNTblVITPNf0XTNXeB2j9v3ywOAot0jt7S20jEtReOFleR4bkx3bUSoRMy
         nTvyGhHSAb3cPDZ0gIgqejenfslanudhWcvQmeiE4u4U/SYjLlgtqfvy9UKxZSSvGxWd
         WowA==
X-Forwarded-Encrypted: i=1; AFNElJ8YNsBQNmqBT8zj6v2cAvmFKaEb0q6Y+zyQuounMZVHL3E6sSVxzKIeOf92wvZsym3W1x/0Z1EGlYc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2bobFWJZS0eRFbzhMqE6/VlQTlBSN6pmuhNumph+IOGsaaDPf
	fUjyMhRUZSsG9VBWL30iJMNSQd7kR9NPzWfeh2YMIs2xNfyYG1/TdL/w
X-Gm-Gg: AeBDietryVF1I0t2Cs1KzLHo1GfDMoeAk5dJ5/ximfZNsPd/jdAcEmtJmZg1g9TwyUc
	IZNoySvm8R5nZLcq47ail1E9Lsx8Oe7BdpwOLjTT72vSTBQdQSLYJeP25Ct7X8g3uD0neeVM1f9
	8Hq4OcyOhFmEOZ4rQGUD+ANJGjjNTSZc8umhfgB697aRlruMvnWW3L4VmeHb9TnnJQKrDddc6hg
	4skVOMaQuXtbfYlFCnTOo5SnlyYUi/SEuu1zpBbcF3s7LQ/tdrAe0aRayZelQSnR1vuRBVdZGWR
	JtN3ScPRMhBxG7blVd3Y0/kMSdsyd1LcWSvu1Es0ii/TpeOXh7sYC6h9luzCBAglpRyaJV36mRI
	ktixAiLknPl737AkHnYnaaoOUgwhMQn2HAOOPfclDH4AhdG2I1/io7c832VnQjaaEb+u3icEU+1
	FGW+Yqf5O2FMANXiyx7d+2jRIvbuWM+dqgNnLfdhyV0znn4VW5f5JlkhBv+m0FFzf81U4keMlil
	xegxb8D++csu0YJ
X-Received: by 2002:a17:90b:5203:b0:35d:9560:3efc with SMTP id 98e67ed59e1d1-361404632e8mr23588821a91.14.1776918458343;
        Wed, 22 Apr 2026 21:27:38 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-83-234.dynamic-ip.hinet.net. [36.225.83.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361417748aesm18242072a91.0.2026.04.22.21.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 21:27:37 -0700 (PDT)
Date: Thu, 23 Apr 2026 12:27:34 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: zhidao su <soolaugust@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, zhidao su <suzhidao@xiaomi.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: Fix local_dsq_post_enq() to use task's
 scheduler in sub-sched
Message-ID: <20260423121149.Ge96e@cchengyang.duckdns.org>
References: <20260423025832.2654840-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423025832.2654840-1-suzhidao@xiaomi.com>

Hi zhidao,

On Thu, Apr 23, 2026 at 10:58:32AM +0800, zhidao su wrote:
> local_dsq_post_enq() calls call_task_dequeue() with scx_root instead of
> the scheduler instance actually managing the task. When
> CONFIG_EXT_SUB_SCHED is enabled, tasks may be managed by a sub-scheduler
> whose ops.dequeue() callback differs from root's. Using scx_root causes
> the wrong scheduler's ops.dequeue() to be consulted: sub-sched tasks
> dispatched to a local DSQ via scx_bpf_dsq_move_to_local() will have
> SCX_TASK_IN_CUSTODY cleared but the sub-scheduler's ops.dequeue() is
> never invoked, violating the custody exit semantics.
> 
> Fix by adding a 'struct scx_sched *sch' parameter to local_dsq_post_enq()
> and move_local_task_to_local_dsq(), and propagating the correct scheduler
> from their callers dispatch_enqueue(), move_task_between_dsqs(), and
> consume_dispatch_q().
> 
> This is consistent with dispatch_enqueue()'s non-local path which already
> passes 'sch' directly to call_task_dequeue() for global/bypass DSQs.
> 
> Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>

This fix looks correct for the parameter mismatch.

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Regarding the Fixes tag: I'm not entirely sure if it's strictly required
since the sub-scheduler groundwork is still a new feature. However, since
it fixes a specific logic error, keeping the tag seems appropriate.

Thanks.

-- 
Cheers,
Cheng-Yang
