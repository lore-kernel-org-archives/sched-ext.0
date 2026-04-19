Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1F7E0FF
	for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776617623; cv=none; b=a0fqWzpLLLJiGBdzSk1HOFcowEk+78P/C89NAWDkgY6kxk3CltqZqf2mrezeMamT/Bt5eBNuq+0/AJyeyOA06Z4LTF5AgEhtxvQkkJ+EyePbff4XvFkOLBGTH0IRIh9V+7RYXNsn7SNAKofsT9UxZrkuB52RXMaUY3Bo5MSjL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776617623; c=relaxed/simple;
	bh=gDEl4ZUxo7xE4AjfX/5d3nOtZRhMgIZF1i1VSNDKRKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW+oWWFdMBehtxIGjXOc1lTbROH+9dAzDXvCgD9eVU4Uopc+U1XpKiq4QnD7EQVuw9fJW9zHDocYW4IlyTAuPuZJ2+Kjri4T6l2Ai8vR9JSnMbR/wWu5UtpXHdC8PQ5XzvPM/1veOewHRoAeTxFW3XlJlAXSJ7/vX8oIi7FrOwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPwF84lD; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPwF84lD"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso707684a12.3
        for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776617622; x=1777222422; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpKw7UI5egXRxsxNzZMiABMaGX0LC5tOT30a5oqSUY8=;
        b=GPwF84lDAYQWXklRzztTa7rbwSe6OJBfk+s12LP0SrYEx24VUzwsSjnrMppLAAX+Tb
         6gm9o7UuECFhqFOPuJgS1mwdE6MuPRjvmUDkhew7VDQUAvNWJflv21mN2P79/SL5hb8j
         f1MAD0M2/PhonsB2vwIoez3sQjYCzhc781kfHSnATMrsUqJWHw/x1Biw98FrA4NnhrKS
         iecoq0eY//HsDErGTUpTSmlBkdhzmGVBZn/XsWs2AOr3x2H5Nm7pX8EUO/+LY0WwSAgC
         ajxUuvqKGWnlFvGiBPmFhAEsawZAajSeMB3m3vwqFPbY9Fe23qdpNi0sAk84Hou/H+cC
         QiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776617622; x=1777222422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpKw7UI5egXRxsxNzZMiABMaGX0LC5tOT30a5oqSUY8=;
        b=YnxB4aVn0Bh5/4txDE8FkcgAUdXxHJDYarJkQQmelRHgfwLUX1Y6OSNqRUOu44Rr9s
         x8RJKMvf4Ylcv1wwSpTFkshAIr3tgwC4HwBqleBlJK9TO80nv+pe+9Bvd7i+74DpSddp
         tq4kzeBOjGWrVbWLFo2PJ6mkTb/a4U3MiF3sps858VZwNuSnhTWRF5fkqQBrAiPOdpHv
         dlqvdQ6MVmFm/QCDcuNTpumXGUBT83WNejUjqRFPL07LSAyzi45jCSNYed8pG6RqIER6
         W06nm0PMg/OccBqMc03052pHgwhd71AfLXV6AmwnnStZh6pA5IkymL1ev7XTf5MBxlrR
         2DFA==
X-Forwarded-Encrypted: i=1; AFNElJ8I/JwsUGt9KpVUSkP6uwFtAF1bxdgaHbQp6WB3urGlo2c/WDDclbxVquUosFZhazIC3s7ZLJzo1HQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxBurrmJsK/H92R9trrEYGlZCkSAbe6omSLOVEMhRDhukrzxrIm
	9v1Qzw5PZcAN2Q2axOIPMcbwwAOQsNv9HRVBSgmtHyc8rVTacJwiYQQp
X-Gm-Gg: AeBDievBaiuxitMQsq5hRpfzyTKIXoVReKQNqxFHmqbpIujTec5P1M2qIMAMiRnDVwE
	DfGl1hMY0zXRyzyxEqe2Fwvn2Hg1t8QhbzBZg7pwN6/nLZPSINe4nrKW7ClIpzx2HZmMNfF6adV
	jJ9If+cSrk000nPe/nWK2R6gRi8Pdse5bZnwNLY7ONSyqtF9lrTXYiml0PsRBUkWF7DtzbsZkm0
	ZmyEWR0vEsFY9VgrQ07q8y5g6fPJ8nI8FDAff7hij3l1LjlVF7eRV4/cJD2bY6ry7dbHmC0996r
	0Obm1aY54SyZrpp502BH8aipSz5lNO7y45FNcsNwFYyMqzSk7bdDc/cFt4+qZNL0MyTZwjFz2zU
	/G8BKog3Jde/2E22OfMjSDghwSP/8h4BXYJyG/iO49vDzBS0ErPAzcYsvsrhJdI7pvo22XE882+
	w7Mx0uAVr3lBpfB0G4a0oybpVb7c+PhhGZ1B6OCE/SfBXxMqlaVNmWy/yxpzn7l7J6PqK6OzmJa
	NpJEJdZaOzTU45P
X-Received: by 2002:a05:6a20:1594:b0:3a1:d516:36e5 with SMTP id adf61e73a8af0-3a1d5163aa5mr2390295637.46.1776617621872;
        Sun, 19 Apr 2026 09:53:41 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-119-66.dynamic-ip.hinet.net. [36.225.119.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa40b2sm5466027a12.13.2026.04.19.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 09:53:41 -0700 (PDT)
Date: Mon, 20 Apr 2026 00:53:37 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Document the ops compat
 strategy in compat.h/compat.bpf.h
Message-ID: <20260420004823.Gde1c@cchengyang.duckdns.org>
References: <75aaaf7a4dd540191bd8550dd181528b@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75aaaf7a4dd540191bd8550dd181528b@kernel.org>

Hi Tejun,

On Sun, Apr 19, 2026 at 06:18:52AM -1000, Tejun Heo wrote:
> The comments around SCX_OPS_DEFINE() and SCX_OPS_OPEN() were vague about
> how backward compatibility actually works. Expand them to describe the two
> mechanisms: load-time BTF fix-up for additive changes, and multi-variant
> struct_ops for incompatible ones.

Thanks for improving this. It is much clearer now.

Acked-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  tools/sched_ext/include/scx/compat.bpf.h |    6 ++++--
>  tools/sched_ext/include/scx/compat.h     |   23 +++++++++++++++++++----
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -423,8 +423,10 @@ static inline void scx_bpf_dsq_reenq(u64
>  }
>  
>  /*
> - * Define sched_ext_ops. This may be expanded to define multiple variants for
> - * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
> + * Define sched_ext_ops. See compat.h::SCX_OPS_OPEN() for how backward
> + * compatibility is handled (this macro can be expanded to emit multiple
> + * variants for incompatible op changes; SCX_OPS_OPEN() handles purely
> + * additive changes at load time).
>   */
>  #define SCX_OPS_DEFINE(__name, ...)						\
>  	SEC(".struct_ops.link")							\
> --- a/tools/sched_ext/include/scx/compat.h
> +++ b/tools/sched_ext/include/scx/compat.h
> @@ -149,10 +149,24 @@ static inline long scx_hotplug_seq(void)
>  }
>  
>  /*
> - * struct sched_ext_ops can change over time. If compat.bpf.h::SCX_OPS_DEFINE()
> - * is used to define ops and compat.h::SCX_OPS_LOAD/ATTACH() are used to load
> - * and attach it, backward compatibility is automatically maintained where
> - * reasonable.
> + * Open the sched_ext_ops skeleton.
> + *
> + * struct sched_ext_ops can change over time. Two complementary mechanisms
> + * keep BPF schedulers built against newer headers running on older kernels:
> + *
> + * 1. Load-time fix-up (this macro). For each optional ops callback or field
> + *    added to struct sched_ext_ops, an explicit stanza below probes the
> + *    running kernel's BTF via __COMPAT_struct_has_field() and, if the field
> + *    is missing, clears it in the in-memory struct_ops (with a warning to
> + *    stderr) before load. Handles additive changes - a new stanza must be
> + *    added here for each new optional field.
> + *
> + * 2. Multi-variant struct_ops via compat.bpf.h::SCX_OPS_DEFINE(). That
> + *    macro can be expanded to emit several variants of struct sched_ext_ops,
> + *    and SCX_OPS_LOAD()/ATTACH() can pick the right one based on what the
> + *    kernel supports. Needed when an existing operation has to change
> + *    incompatibly (e.g. a callback signature changes); the load-time
> + *    fix-up above only handles purely additive changes.

This is very clear now, thank u! ^0^

>   *
>   * ec7e3b0463e1 ("implement-ops") in https://github.com/sched-ext/sched_ext is
>   * the current minimum required kernel version.
> @@ -225,6 +239,7 @@ static inline void __scx_ops_assoc_prog(
>  }
>  #endif
>  
> +/* See SCX_OPS_OPEN() above for backward-compatibility handling. */
>  #define SCX_OPS_LOAD(__skel, __ops_name, __scx_name, __uei_name) ({		\
>  	struct bpf_program *__prog;						\
>  	UEI_SET_SIZE(__skel, __ops_name, __uei_name);				\

-- 
Cheers,
Cheng-Yang
