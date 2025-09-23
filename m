Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD1224F6
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623946; cv=none; b=Atal8WxYAjI0EI89XkexHv6IVVYxpzqYGjE0wuJnbbHT76nTsTV/vSRI4Faegnh/bekg5QDIMtxJfKY1AX9MhVgEx9tF1/pd4gI1yLK/Ynt1vZgrBJYlmFH7BeD7WaNjwIOKf94CPTIVninACFI0Bu3H+fucbsgfXZxetdEocMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623946; c=relaxed/simple;
	bh=9I+UfsvIx+bsD4niyYaXYH6gHpsHBUv5FFHGyAAC3ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaN5Bh3EzJqZPU2DKSDjKVnwjQm6fwVpcnTwygWByx/u5xxYt3GDFyw0ytYDaxflx82B2XUiLaf18jndFyxpCma1B5uStbDHc1QD7c3Dr/KS0tHH+8fA52wrrvFlqdx+YzEWTYEWfzcM2PF3rWwwoJg8U0w4czKf1wn6Q8HQnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6Fs9+68; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6Fs9+68"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-631793a68b9so5147524a12.1
        for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 03:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758623943; x=1759228743; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NnfkqnOJdsB0bfPkZ1igYkNhvejCpYg0U/vTuy5A1tc=;
        b=A6Fs9+68z2QJhN7CNxhMwAGXmXDkWesBre9N0HUgXE2MKFP5wnrOSvAhT5TyFj7JMC
         2Li3UE1nmTiEHhh2+gdEyZJKKznzCNVh+YpFfXt0/8ubmcHvIbsEHqyroHJlGH2PrKPX
         IX1THtOozzmiMs2G0w2gW+CpH15+EVDE7112P7BxrNSFX+uy3Jo2EJu4+poL1exwg0fD
         ttJc6xS4W2d1uY9gjE9TAXFSDYzOOA2xr2f3HVWMLq7Mp5/ykjs56iB75ZYNZBKPfw0S
         myQR+pCGxsUhi8OLpZXIvjV5IPYbH5yqtt68kGvKVlVBSXUPmo0rPEawYo/D/+SyWfhZ
         SELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758623943; x=1759228743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnfkqnOJdsB0bfPkZ1igYkNhvejCpYg0U/vTuy5A1tc=;
        b=YnHdnHjTkzwe3ZO/Zt6Can+EgOi3Y0UEa/9Y+hKWTXPBbGaxnzDJS7FzlAjMRDlEhZ
         MsFCDzzDFTa847uBxruDmVI6JlTHXEGgH4VakSrPCy6TAoKxSy9fIkwQD+xB5Sv5mVJ6
         19JyUMgwKd+kvJc9Gfg0vfrg44SbXCH87QotUKOCpy6xRL4pyH3egYd4jd53iFpC59UG
         QCzDeiqCpx25ViSfbfQnwEbShYTMiuyaSVc8r1vf/T+5bEhy1sBgr4v7jB+9PLh3DxP8
         QVIh7K/js7SmVzMhfFIF/BO0pio1SbKLn+X0D3s87Kq+FBOzIUElBOV6QiT7GnJEhqCB
         7vpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSZy4O/qt15En8y/00hoKmE6F5uTgPZ6epO6PFO7/M7uKd1l3DV11BOSQJKRdnn3fI07hkMMqg5T0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1TD6XW78t0a9HaLOFiAHFeMahUUoEYrOYFjUQ8MIXmgDBSWGd
	+KL5oya/u9foOB541MBAm4qA3cB7Wegm0hokocrEAN+6mRk1D0IfCrWssgR57dlyvmbyYjTFTyr
	9AobwvRb8KpzP+fheH8luR8Qxm6I7dZs=
X-Gm-Gg: ASbGncuAvrKpzptfjCfiejKeq517LYkqDJPyFRje18dT/5B6YZ3TBmjgvMHKGRLWfNv
	wd14s2f1SNIrn4no7eq9RSEtNo4qyloa6ASHYMAH+gYHSzdziRPFBmKNdiJlVk2YElTEsaQ2gL7
	STJTMDMroz5baar5Vq+NiNHWEQnuLTU2RJfkmJ5rAVvNQmyNF3VyMBerCbKLGRsTm949Wjf/4if
	+hMnB+EpQ==
X-Google-Smtp-Source: AGHT+IGe8BueWIvyXCDLHwL8VpMfxPGaA/c+GGWafGvE2t67inmTkzI9pV52mWfvHL17NVaKT6Khw4wvn8Yi5AG6Q3o=
X-Received: by 2002:a17:907:9484:b0:b2e:4ab2:485f with SMTP id
 a640c23a62f3a-b302c10a345mr210661066b.53.1758623943305; Tue, 23 Sep 2025
 03:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250923091634.118240-1-arighi@nvidia.com>
In-Reply-To: <20250923091634.118240-1-arighi@nvidia.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 23 Sep 2025 12:38:26 +0200
X-Gm-Features: AS18NWBYse4BMQwVtmlQ_EXCFADp-5s0Or4bp9_W7wncLZyqeCwKDe4OHa96rDU
Message-ID: <CAP01T75_tsZoGX0SghGtO5V6LJOkDEMDcocWHZwoOpXmS7cK9w@mail.gmail.com>
Subject: Re: [PATCH] sched_ext: Verify RCU protection in scx_bpf_cpu_curr()
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	sched-ext@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 11:16, Andrea Righi <arighi@nvidia.com> wrote:
>
> scx_bpf_cpu_curr() has been introduced to retrieve the current task of a
> given runqueue, allowing schedulers to interact with that task.
>
> The kfunc assumes that it is always called in an RCU context, but this
> is not always guaranteed and some BPF schedulers can trigger the
> following warning:
>
>   WARNING: suspicious RCU usage
>   sched_ext: BPF scheduler "cosmos_1.0.2_gd0e71ca_x86_64_unknown_linux_gnu_debug" enabled
>   6.17.0-rc1 #1-NixOS Not tainted
>   -----------------------------
>   kernel/sched/ext.c:6415 suspicious rcu_dereference_check() usage!
>   ...
>  Call Trace:
>   <IRQ>
>   dump_stack_lvl+0x6f/0xb0
>   lockdep_rcu_suspicious.cold+0x4e/0x96
>   scx_bpf_cpu_curr+0x7e/0x80
>   bpf_prog_c68b2b6b6b1b0ff8_sched_timerfn+0xce/0x1dc
>   bpf_timer_cb+0x7b/0x130
>   __hrtimer_run_queues+0x1ea/0x380
>   hrtimer_run_softirq+0x8c/0xd0
>   handle_softirqs+0xc9/0x3b0
>   __irq_exit_rcu+0x96/0xc0
>   irq_exit_rcu+0xe/0x20
>   sysvec_apic_timer_interrupt+0x73/0x80
>   </IRQ>
>   <TASK>
>
> To address this, mark the kfunc with KF_RCU_PROTECTED, so the verifier
> can enforce its usage only inside RCU-protected sections.
>
> Note: this also requires commit 1512231b6cc86 ("bpf: Enforce RCU protection
> for KF_RCU_PROTECTED"), currently in bpf-next, to enforce the proper
> KF_RCU_PROTECTED.
>
> Fixes: 20b158094a1ad ("sched_ext: Introduce scx_bpf_cpu_curr()")
> Cc: Christian Loehle <christian.loehle@arm.com>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
