Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65B1D5160
	for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776822809; cv=none; b=VRRqHFVqG5l6VZtktfIn9MeNkxNDFjQ/4wU7kK9mrRnnKW8v+U+avQ4XYATRbTKNTs5fotGSgbI2MQFtafCimMidjnkIO2s1bXx5yUq92zkpIaplSyv2s0ZE+I3FFNvrOa6pu7mTWDJY8+mqKQzzfIy5LFz9o986JPKwHkxThwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776822809; c=relaxed/simple;
	bh=iPsuJ+3YNbu3A7xKPhwlOBCHI0w4RA/i+A8/XLPG3/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy6KfE1kI1Y8OMtthFV4H6Mnekk0r4/+5r0ab7ALL7iaSYRqW+zJHlka+9HPYfsZpkIb+XwINnkJdEgL3+298/WlLRKxd3SMoiOFusoe211dj8y9iYt5BJFPz2UUle89XWm8MxKc9Si5xTT/agueRK6m0uB0FmSB4jRbNYb+0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/9uhOkW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/9uhOkW"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so2991206a12.3
        for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776822808; x=1777427608; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=88pOpxM7/TmqzN0A6UrOhXDmQlCvSHTQ3maZE1RsEwQ=;
        b=s/9uhOkWRlDERMTZmXtqZkyCPqDUkL/YVswrgRmhEkB6Dr73Wyj+Vuv3blBkrqfHMf
         uwdbgc872dKp5wJ41c6FgZgor8+I1u60AbsZqu7+Xv40rnFVebYUNL7ljqbD8pdEoy/0
         vuaoG4E0/GKm+W15j+RCD3a6y9Z7R2rhAEAeEfHoj2cyl+a2Vrvfn2f8HxIoeIj7Gx5e
         X36jCcQxt9oTq5EVr4KZA3OhIvysi1N/pychrG0y3/mzvL54HSICNlleeURCa9nIXKtK
         PSrBHfNO5feBJTUnmfzhNuIbY4v1WAFh3tnBoeA/SJrtPqKIrQhKg4j7z1BQDfxa6iHV
         I4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776822808; x=1777427608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88pOpxM7/TmqzN0A6UrOhXDmQlCvSHTQ3maZE1RsEwQ=;
        b=dCBujFfx6bxdQRkUEuUY7fHcDFDq7bN7hLPQHbI1pngSJyiXv46GA41dErFWfsMB+n
         /nXKEL4V+7T9LYbEZ5g0fRKKWdoZsaHlkdK8Rq3P3+8E9GDQGPwwzUGrJdBUfHvZu4k7
         Zlr3O1KD/szkgzzLBM2RpncxoosBm8+BMSXFMU5qJonnfuetl7bRfJ5B3cb/nTP7EunF
         LHaZj9/PVe/rtT34x1Lt4T21Ko01qmXfI+AtRZWfhr/T3WQCogmXA9udAiHxSQJwm82U
         dy31v6dRu5Bmr/BSckLnByiu+zrXKkgE115wIYQcV8zOOpqp9Jrp9Ua2bV8iES6dpBKP
         Kw5Q==
X-Gm-Message-State: AOJu0YxHNGE/IXgsOiR/HL1ZcVybRI8fFR/gZRNs3gbM52usf1hi2mVo
	1xEOahGZyi1SorI69wvgmpXvsCPtlNUWMpPiNTAwZ5yfCDAa7yZ24p3l
X-Gm-Gg: AeBDietw+8u/9WYW7WE/d1mE7MYHut8oVDTSFXw2oHj93QD5s+tdyrmvAOXQa/qVfdu
	GvgJhnDVeZ+fmK21Yu7aJt2laY/OFTHY/punpcpmpdb09xRQdo8d8ADsfe3D+FLmlO6C8PiZvfD
	A9XWuGnjQuzOhhgq4X6NRxTekCPiEfj+CS0NdJzbjW1L96e45oy6Xy245cE00HB4bmsQZMm5lRj
	uagPNHpiLTktJbaGKPLqhu6t6QKquwkGMxG+iDSiq0MfrHeJFa6jEkRi3n8O17bjsNOLn0YvCQ8
	ta4CzQnRtbEo+ainSfCUxpqrSLKjaLob+88RtCVPltOEhGWMxpT35sZovEotFZNE5Y4grlXnCaa
	t55yqUOKQDRnZXj8+/88BCr8luqjlZuU/6zT5+2M8xoB0Rgx6rIK52EqRHwqewrzClQyS7iRohW
	WhKPYSkOArr8PCA3Cm5kEg/67bTy+jxIfZ3rJswzwxa5DVAufNrLaiKMpHYm2EBQMIYoM3M+RrW
	9U8uoOXHY+V1QVl
X-Received: by 2002:a05:6a20:2591:b0:398:7d6e:27f4 with SMTP id adf61e73a8af0-3a08d6eb34cmr24523945637.1.1776822808054;
        Tue, 21 Apr 2026 18:53:28 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f0811fsm11321339a12.0.2026.04.21.18.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 18:53:27 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:53:24 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Refactor
 scx_root_enable_workfn() enablement task migration
Message-ID: <20260422094555.Gaec7@cchengyang.duckdns.org>
References: <20260421074154.584737-1-yphbchou0911@gmail.com>
 <6cccef586daa450e322d9659d4e64e13@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cccef586daa450e322d9659d4e64e13@kernel.org>

Hi Tejun,

On Tue, Apr 21, 2026 at 07:30:18AM -1000, Tejun Heo wrote:
> Thanks for the patch, but I don't think this makes the code better.
> scx_root_enable_workfn() is a linear setup sequence; length comes
> from the number of ordered steps, not from doing unrelated things.
> Each extracted helper has exactly one caller, so the split is pure
> code motion. The locking story and the error path both fragment
> across three functions, and small things drift - the TID_TO_TASK
> read moved from ops->flags to sch->ops.flags, which is equal today
> but sch->ops.flags is mutated elsewhere (SCX_OPS_HAS_CPU_PREEMPT),
> so the two sources aren't guaranteed to stay in sync.

I see your point about maintaining the linear sequence for better
auditability of the locking and error paths. You're also right about the
TID_TO_TASK drift - checking the immutable ops->flags is indeed the correct
approach.

Regarding the ordering of the task enablement sequence: do you think
it would be useful to be included in the kdoc?

Thanks for your time.

-- 
Cheers,
Cheng-Yang
