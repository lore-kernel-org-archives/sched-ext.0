Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11AD359A82
	for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795547; cv=none; b=QOq37GrlZKCrjmzBkiuabf54Hu3xvrJ8tAaOWLrYVhudOfov975OAQxPTdwWby27issBCWb0eXt1Th+Dw4IwDWDob245FIJVRKDx6uPxLdlQgCRD35eVfAUStUduvFduZyFyjdCn+2eT7sEQOaFM16zPVlGM1ket00EG9/byc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795547; c=relaxed/simple;
	bh=oPEbfp36dBjMFYMndMugB7mBmT0SSQzvrn5zwN9Zb10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnpQLCUTJH7wf6HFF5pjmTeq+0OOHWBQ+2u6zcDYZYfaxLMOJdDev50qXFpaTdDxomcPqktBsxVKSTL/FvnPnvxCzTEcSfs4FywrTsoo6AN4tPmm12EDWu/gJSSJaUEGXQ3N0pKd5AwNQRtogFEQJ3gM8WbqDa+eRRc33+47lRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgL+iJ9v; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgL+iJ9v"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso3058266b3a.0
        for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795541; x=1777400341; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gUDFKv87nX4F7ZSX9m1mx5SoReNhVf8R+aQD1US3Z1A=;
        b=SgL+iJ9vNVniplMpG6NOnJRpXk95nRvjX//8i+lQuHDtETt3IYZYZpmQtwTGGvCrcl
         nw27mqVRfcCjzLsmabCV1rIon1f4Ypv5FrJ2+c74xkkKblZ18vm4T3qF3baj5Qe15ESz
         4jXssd0vg4b8bY2d64/NMsTj7x5piTz0dHyFTBCjctHHXQIJSNruNZ8TBIRKlMkpmZm2
         Np9Riz3A6R6NZH2ugvFC/x6d/PytyPywgReKPcr7R2/P7DhnlL6g/uFF/qWYh3RfrSfh
         /2A2V2gxaJXUpJiP3lcZxc0/G4zlVRlvFAnRtPJAcoMhqD9V04mLy7h7kwzsklmJLTJL
         m7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795541; x=1777400341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUDFKv87nX4F7ZSX9m1mx5SoReNhVf8R+aQD1US3Z1A=;
        b=TsZIChLxOJSGHQK8kw6kcH95eruU5KGF+jEAAzAt7MyLN4HzTrxnK6+KQYDbrODajI
         fwCo7iKUi+20k1ehw6bJY4X94vl2eo0y2RVGwtcgqbMqAjAqii+XchmK19iQJmiyT11/
         PqLsW7ZUoLL5+k5aSxSEdong03hF15pVjN+oRqmlJiJT8FM2fkEoZXV73IKk0dp9b7mH
         GtU0MHp6NI4s2sCXibMBfxTDait4cxZIi2MzbHdUF6S3IR5c26GLcQc0Rx453jK7Er56
         c81Px1kPAGILz6F0hWDLC2fXDPiuljj4wQibceqM7M7WN9ah4Amw/VeR4HwI8egd3PXW
         dqfA==
X-Forwarded-Encrypted: i=1; AFNElJ9vlsQFUus0POkt6cKUwKnrLg72HnU0G4TagA6VZJ4taLc7dULm3z2Ba5vmNc5NbpwmtGHPtgbS4Yk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyst25pbPp+ebe4+3jIRT3ktzvTXcWYkpjwDIGuoNy/qpLBnJdL
	Om5rchkPTEVzb00SX6Tfvbv7m/Wn8XpZ33Xc8jG53NgKQ+WKB/CTq7PJKxQ30lCy
X-Gm-Gg: AeBDietTrQsYelZ9DqWVifKhGbXtV81IhKQvlijLxwEbxMn39kgek/tU+z2C7DXiUsZ
	78cfz8gOZ8dhx9mw9Cv9FkKsNGOdu4PTm75SXcu0uWK8nnnZ7SfYgpjCFDc9lcq2JWyX7ZBMjpw
	WiAMzlnu0ZGMF31S3L/aVOgZBxkrqk06jcnC3v4fnmMe3AYPkLZPZMEeXKNIUp9mTqFbOtin6S/
	MTaI9tLnpOtthajP/7EOagHiEFFBIDST0yT0POfD/Fly5LArMQ3VacX+BqJW+wTkP92RIT+21u8
	CNyS88nJrCgbb2JgxAbkVm7eKKn06BmcrNot+sixYlwPjNcaBGxPFuvhmaZEZCo96G0SSYwv3JB
	di0SaS7ApNRux3a4eonf6xBEvbSUGGKcs6J/SVBmcreu2QwGmOsAzc2C+i0rKTdsSjLFdhCH71n
	XyL0/+SckyX+cyVabzs1+w8Gul1azgGkqfUJNyCzriMqN9c/BHKwJBqu3mZULulLIbJSe14N4DO
	igTtzpQy0m04tws
X-Received: by 2002:aa7:88c7:0:b0:82f:42bc:3386 with SMTP id d2e1a72fcca58-82f8c889b28mr20004257b3a.21.1776795540809;
        Tue, 21 Apr 2026 11:19:00 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe901csm17870268b3a.48.2026.04.21.11.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:19:00 -0700 (PDT)
Date: Wed, 22 Apr 2026 02:18:56 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, emil@etsalapatis.com, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCHSET sched_ext/for-7.2] sched_ext: Topological CPU IDs and
 cid-form struct_ops
Message-ID: <20260422015408.Gac88@cchengyang.duckdns.org>
References: <20260421071945.3110084-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421071945.3110084-1-tj@kernel.org>

Hi Tejun,

On Mon, Apr 20, 2026 at 09:19:29PM -1000, Tejun Heo wrote:
> Hello,
> 
> This patchset introduces topological CPU IDs (cids) - dense,
> topology-ordered cpu identifiers - and an alternative cid-form struct_ops
> type that lets BPF schedulers operate in cid space directly.
> 
> Key pieces:
> 
> - cid space: scx_cid_init() walks nodes * LLCs * cores * threads and packs
>   a dense cid mapping. The mapping can be overridden via
>   scx_bpf_cid_override(). See "Topological CPU IDs" in ext_cid.h for the
>   model.
> 
> - cmask: a base-windowed bitmap over cid space. Kernel and BPF helpers with
>   identical semantics. Used by scx_qmap for per-task affinity and idle-cid
>   tracking; meant to be the substrate for sub-sched cid allocation.
> 
> - bpf_sched_ext_ops_cid: a parallel struct_ops type whose callbacks take
>   cids/cmasks instead of cpus/cpumasks. Kernel translates at the boundary
>   via scx_cpu_arg() / scx_cpu_ret(); the two struct types share offsets up
>   through @priv (verified by BUILD_BUG_ON) so the union view in scx_sched
>   works without function-pointer casts. Sub-sched support is tied to
>   cid-form: validate_ops() rejects cpu-form sub-scheds and cpu-form roots
>   that expose sub_attach / sub_detach.
> 
> - cid-form kfuncs: scx_bpf_kick_cid, scx_bpf_cidperf_{cap,cur,set},
>   scx_bpf_cid_curr, scx_bpf_task_cid, scx_bpf_this_cid,
>   scx_bpf_nr_{cids,online_cids}, scx_bpf_cid_to_cpu, scx_bpf_cpu_to_cid.
>   A cid-form program may not call cpu-only kfuncs (enforced at verifier
>   load via scx_kfunc_context_filter); the reverse is intentionally
>   permissive to ease migration.
> 
> - scx_qmap port: scx_qmap is converted to cid-form. It uses the cmask-based
>   idle picker, per-task cid-space cpus_allowed, and cid-form kfuncs
>   throughout. Sub-sched dispatching via scx_bpf_sub_dispatch() continues to
>   work.

I have gone through the entire patchset, and it lgtm.
For the whole series:

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

I have two questions regarding the current implementation:

1. Regarding the ext_cid feature (same as ext_idle), is it feasible to
   implement this within the BPF arena instead of the current approach?

2. I noticed rust/kernel/cpumask.rs is already in tree. While I understand
   that arch support for Rust is currently limited, would it be a good time
   to start adding Rust abstractions to maintain parity or reduce code
   duplication? (as I discussed offline w/ Andrea about re-implementing
   ext_idle in Rust, and now w/ ext_cid as well)

-- 
Cheers,
Cheng-Yang
