Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EE4293B5F
	for <sched-ext@lists.linux.dev>; Sat, 18 Apr 2026 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776495065; cv=none; b=RX0iCFArBthgKxkFDkYjUqNO6eiMTBK3Y8cXuKAHGWDIs0f+JFjnK1YqqXgiF5wjHn1IUCks2U41XR8CVMV71w185qP8b9hq6a6nniBuQ5flAok3RnxqDqbJIWHLOw0IVNu/NuPKXRvvo1R7U7OxdP5STPdvuLLXyoQNY/GZDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776495065; c=relaxed/simple;
	bh=e3YyRXPatKHXQUpoFHJ6hjWTEu36mR7kuBEkiOyvh4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuP81MH4GMDrkvfTcSbHpNyVUihXuqBJHgQpXpRTn+7OitqchKyFfqOkVVu94GBwDyk1ObjkcEthVNAUdZ2b6qN7mtBfskrp3mVAcMjhBQlsXCI6WcIsamTPONIUQJhrJMS0eYK/kQGcWQXlZM1ws/qQAiDbm+V20UJN2TKBbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi9Qr+SK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi9Qr+SK"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82a655cfab5so1436928b3a.1
        for <sched-ext@lists.linux.dev>; Fri, 17 Apr 2026 23:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776495064; x=1777099864; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fpjXYgjD0UAKYB7RSFWzt7RZN8BSmYe6rqn4RtQZ/8E=;
        b=hi9Qr+SKaMbjd6khgfK+NxnfkMZrb5OdrAaqRqfxk3k10uG7/+vL4yHbBBLIsFDHDF
         Aifj/BLBSqfxDs6lXfGIGzWvi1usXjh3fKDiWcQmiDVd7AFXMlvvpBwGLcg1d8R0PJDe
         1V/Rptl8a0CiowigbqL6Vz84eb/d3cgxeF+7OwwNHLK30z7dpeKAANSyUQOxjxRNOlva
         9NsUbpccUjUcMvYZYw1rRG+5QpPkWtC/Ulfp4/3PEF+1jHT45NsFIWtWvqjFK/NWDLcD
         4WtxZvI+ztZZ9hwkc9E0QSQSaEGj7vpBLJt8w5Y0SOcMCEexpOopS8sUdStsknFMh50A
         WusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776495064; x=1777099864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpjXYgjD0UAKYB7RSFWzt7RZN8BSmYe6rqn4RtQZ/8E=;
        b=SusWLStUh1DLsBPlFdgZrNqMJGWxkzugeAKvnbCYor7m04wsziz5elvIy9VI18UvpA
         x9PajVWFJ89/jpJaaeXSTyGY2ayHd62qTJ1mmtkoC13jBJSWEGWgwt+HMEEwBZ4FlxTW
         9o3xkZYGUqqCGPBq2EXwYP8GIvDBi+q0Ib/kslyc8tyiC4LzpdqbmL3zP1KRgBt3Sa84
         7FerRIxbRho6g1yYw7X0Ak4pDBDpMj9OQWId5DSvtmQrIbcC3Jw+gk3/CtVsuPDUQS9p
         tbSSGqy35aTN8/EjkAnwRx/MmpUSQYprMOZa6lq3Bi/X9ON9jOTC2ufXrCm5ooVpjL5A
         4O2w==
X-Gm-Message-State: AOJu0YzDQRAf0CAc+KBJ5itUnhpd7kd4N4yOpCbV5agX1l0ECjmpBnIm
	MoosLIR8UfE0w2PpdGbL3hbSOr1VJROmsteudB5PJkjOfxCN1Ytn59mR3SQvPe2+
X-Gm-Gg: AeBDietjrXukPsDme3SUSdiaW2wR8YvtucaSYipzwZVKmGxo79cWNu+a9LwNnFiXyYd
	PKx/eyVQW4UpAf8DAnMIqiQbtjIMrRFCqWW+Of72tAOhXbee54MfUEO4DAPINFyCgfDBAkeBFwu
	eKfDBs+wjp1kwKsu0iU/a1fpqB8tFOuayFNX0aGeOBg0Y1W5Nr/hqKY9CWwKdC1X302ZJJicwad
	TWZ9NKO69bMBtYKcTH7xfvJMwdZ/T94+YFQ/4tF7+bHav7nUdgdgMOfcfslNeLesU0A+pGz1NS7
	d1TM/kGCJc+bhhSVBpCMHtKBcLkf5/sOEFrjR/ECesTqFI7vmntjzhr9m/pXlecmTZ40ceTZxbG
	BHamSKYHJPvDXjNUWhOEOqZBE+8ZEzGJ3pxcAaGcBf7UNtZGWh4d/KwbcNUSMLMIsrqiqEGcYSO
	sPvhYMYS36Ijk+/VUO6Aap9+vFa1nslYVfnYn5m0pQdKS+FU6ZVmbcgV1MV0/Drih3ViYABpubf
	+5aQ3AoWhb2RUgV
X-Received: by 2002:a05:6a00:2889:b0:81f:3f03:6838 with SMTP id d2e1a72fcca58-82f8c838e6dmr6325234b3a.15.1776495063931;
        Fri, 17 Apr 2026 23:51:03 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-119-66.dynamic-ip.hinet.net. [36.225.119.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm4138563b3a.20.2026.04.17.23.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 23:51:03 -0700 (PDT)
Date: Sat, 18 Apr 2026 14:50:59 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 1/2] sched_ext: Deny SCX kfuncs to non-SCX struct_ops
 programs
Message-ID: <20260418144249.G0885@cchengyang.duckdns.org>
References: <20260416064715.1008437-1-yphbchou0911@gmail.com>
 <20260416064715.1008437-2-yphbchou0911@gmail.com>
 <c95fdfc9fcd55fe5323ae2d8d46fa274@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95fdfc9fcd55fe5323ae2d8d46fa274@kernel.org>

Hi Tejun,

On Fri, Apr 17, 2026 at 08:53:40AM -1000, Tejun Heo wrote:
> A few things:
> 
> scx_kfunc_set_idle (ext_idle.c) isn't covered by the patch. Its kfuncs
> (scx_bpf_cpu_node(), scx_bpf_get_idle_cpumask(), scx_bpf_pick_idle_cpu()
> etc.) also call scx_prog_sched(aux) and hit the same OOB pattern on
> non-SCX struct_ops programs. Please add an in_idle check in the filter
> and treat it the same as in_any.

Ack.

> Separately, please also set .filter on scx_kfunc_set_idle itself. In
> practice, the BPF core dedups filters per hook in
> btf_populate_kfunc_set(), so the filter is already invoked for idle
> kfuncs via the other sets' registrations on the same hook. But it's
> confusing to read the code without setting .filter on every set.

Agree, will do.

> The following line is too long - please break and indent (it gets
> longer still once in_idle is added):
> 
> > +	if (!(in_unlocked || in_select_cpu || in_enqueue || in_dispatch || in_cpu_release || in_any))

Ack.

> Once idle is covered, every SCX kfunc set ends up in this "context-
> sensitive" list. At that point "context-sensitive" no longer
> distinguishes anything - it just means "SCX kfuncs". Please update the
> function-level comment and the two inline comments ("Not a context-
> sensitive kfunc - allow." and "Non-SCX struct_ops: context-sensitive
> kfuncs are not permitted.") to drop the term and talk about SCX kfuncs
> directly.

Ahh, thanks for point out! I'll reword them and send v2 patch.

-- 
Thanks,
Cheng-Yang
