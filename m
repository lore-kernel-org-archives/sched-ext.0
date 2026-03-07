Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C426730AD00
	for <sched-ext@lists.linux.dev>; Sat,  7 Mar 2026 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772911314; cv=none; b=L81SdbogJN+X5oTTJOPz1/U3aVNcU7LXcKug9BGVZbptbGl5vxn+tgXnrq57YA5Sn1pb/5vWkaS47z2b+BLXU5b/LcWLvye1t/qKLASlS8SSReQ7qmAcOFdPF7H/UnSFLgf9Je30C3prnBtfRRMDDsGD5KVAubuuQiKDIyzZmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772911314; c=relaxed/simple;
	bh=jMWyxEuNFrgWP5H+sSR8KxYO8PTuntQLiH/dBVc/oqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU9yZn1/FcbrAyBuIWpf/wbBCbRUvOp2OayMpwo1J+k7JsD0r2wQxR+ZtWXptuGWtQ4/ZfE4zCVdqTCJQvi9S0lVSX+KrnOVKDc4vNDAObs9TsKjy6m4VQpIFVk2Se8wrno5hp9ZDNtHwqy5Fu8V4ANLJxKBKTelj9hyTqPrysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NV7vaii/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV7vaii/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so115918945ad.2
        for <sched-ext@lists.linux.dev>; Sat, 07 Mar 2026 11:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772911313; x=1773516113; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TowxMtXPOrdMBAqZIgBgb4h952My6F99dSFrGbWv28=;
        b=NV7vaii/8VwriUWY2ZibtmwAyNWXAP0FQPb4+8nOS6OoSJCrY9I4a672JkumjhwL5n
         HI5fj4brOuCevk5n02ETHjPaUAkyd5amyb+FOZdf7WArexS3kN7odQ9c/kz1ZgDFzCF/
         QcmcjGvSnriRcyqYfpfCxJ9L7CzqGHLCTx3Epbl0RiGmvmWB4uLsx+w0VF34atH4nZR/
         U6OjapjKM2qvASut7ins4B/HsK7/LNUcqWe1u7fmZudvqGFp33kfhYCDJymIcNPJ4PEG
         g1cqpVeCqiHLA4a/a0b3myEqft/6qRt2MBKLWO0whXTqWceHj3mp58Etro1NXd9PjmCT
         KuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772911313; x=1773516113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TowxMtXPOrdMBAqZIgBgb4h952My6F99dSFrGbWv28=;
        b=dp/EHFnIZ4H0rgI61teafxV01eSwD+/VTvHmee+1OW3bBLFs0T4eb/J4Bswn9c9nOr
         /katBWp/GKVNwxkunBoeaTh+SpDjU9q6QlCDMNVwD+vVnYaLxKA2uSEEenbXK8jsu5sO
         v1QE9zulSFnx7ox9BaVHDsnHQB/NHuAbat+b2AMkwDA32hDCLasIe19/DLNM+2ugk9m4
         kJr5qEHUv61vCfYWDvaRPCjsupu63nq/QCmHG8Umdoh50aaWgfboL+Rud14D9lGOORVk
         nks3yxs85d4G8HDwn4cS3bimfKzwED72pZWCToyWIjVo7fjDym1gXDCgaBYP14ReO1vl
         rAaQ==
X-Gm-Message-State: AOJu0Yzby22xUXF598P8EmmPkwvGsZknew3pfZZNOGP1yvR7c23AvY2W
	jglM2QZW9ItDkAMIVMLVQVIvXB+0OmYNbefIUXV5vfwIGrrC4cY1xTIJ
X-Gm-Gg: ATEYQzy5LQwkB/rnb68pEvmFC+gVm2Mj0KFpViJPJDGz4jE/s+plxi+aeoc5Puht3xH
	Q52dCQj6qKweWO7qy7tpm1BOEULAhIqGWoat6UlqSqQsVt/rXw3Xy0KoORG5d/zKih6IJci/BT5
	2a0b1PjldOwkUpLpY6OEuUL9sVW1KspMOyz+Ir0S6OdrAbjR95zS913mWq0HMH4rPvJdsdm3yPm
	adKo0c2HVpwnwsXrrzPgP+am37t8Ohje0svT3EcWFUFapWMgnEtu16VROMJXka3eMuJ7IHYL/xL
	rEGSn+KodMPE7n5RyO/TFXxEdNHPIRUDK2jzQcb98sLRMEX+6lEpdQms76qlaSImJqVyYhX9b48
	S04DaoScZsiAagZr9fSpXIshxbB7YFKjO+L0EnQm8m/GrokbBnZ0OeS74rWQdzI6OsbyvjifqXe
	JxBAL7iBe/yga51boRjMZX3BHNlTEI
X-Received: by 2002:a17:903:1ac5:b0:2a0:c1ed:d0d9 with SMTP id d9443c01a7336-2ae824607e4mr66537705ad.46.1772911313081;
        Sat, 07 Mar 2026 11:21:53 -0800 (PST)
Received: from eric-wcnlab ([2001:288:7001:1099:80f8:4f1b:d5a1:9c83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83d85a2asm80489325ad.0.2026.03.07.11.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 11:21:52 -0800 (PST)
Date: Sun, 8 Mar 2026 03:21:48 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] sched_ext: Use READ_ONCE() for plain reads of deferred
 reenq flags
Message-ID: <aax6zKn9Y4maBz6d@eric-wcnlab>
References: <20260307190843.4117532-1-yphbchou0911@gmail.com>
 <aax4btmx6JIQLBc2@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aax4btmx6JIQLBc2@slm.duckdns.org>

On Sat, Mar 07, 2026 at 09:11:42AM -1000, Tejun Heo wrote:
> On Sun, Mar 08, 2026 at 03:08:43AM +0800, Cheng-Yang Chou wrote:
> > commit a90449b12682 ("sched_ext: Optimize schedule_dsq_reenq() with
> > lockless fast path") introduced lockless reads of drl->flags and
> > dru->flags via READ_ONCE() in the fast path of schedule_dsq_reenq().
> > However, four read-side accesses in the locked slow path and consumer
> > functions use plain reads without the matching READ_ONCE():
> > 
> > 	/* schedule_dsq_reenq() - local DSQ path */
> > 	WRITE_ONCE(drl->flags, drl->flags | reenq_flags);
> > 						   ^^^^^^^^^^
> > 						   plain read -- KCSAN data race
> 
> Does KCSAN actually trigger on it? The writes are protected by
> rq->scx.deferred_reenq_lock and reads are protected together with it. These
> shouldn't constitute racy reads.
> 
> Thanks.
> 
> -- 
> tejun

Thanks for the clarification.

This was a preemptive fix from code reading, not based on an actual
triggered report. I'll hold off for now and ensure I provide KCSAN logs
and verification for such cases in the future.

-- 
Thanks,
Cheng-Yang
