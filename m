Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E262619005E
	for <sched-ext@lists.linux.dev>; Sat, 11 Apr 2026 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775912269; cv=none; b=eWBUtBktolRmtBZuxSlgd4+7CiCTfTctBqSZ+uKARNAlP90BGcVJ/tQlwcmnQaKKPsO2Qavi7uRKqzQ4IQG8p0EA+ts27wznwP4C5zIZrLx/QGlMZT+I6gYjkxg7+X59ZdFHIGhXchfVZYCEOEoU/Zz2MPxSn1P4g7yYyGjjcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775912269; c=relaxed/simple;
	bh=6TUk8d7GMwPd+BAVQiLrDrpb+kDYKil7AE6NM5oSRZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3Tw4z6mIJyCzyj4JFqjZWrqkYiLYblJsR+alAYe3zKY7Po4yjJc61QHZX7BCI8fkAor99hg+N3kUXeNkT5v4p3q3dJqJu2V2bef4KoDfLBJUR+L2VNGGj2Q9S2ZWQYz9rrXMUA7oB6KJu7W0STVh5Nl/mT5iXxGJGgHLLcw0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM/BJqDz; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM/BJqDz"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c766a95a72dso1927351a12.1
        for <sched-ext@lists.linux.dev>; Sat, 11 Apr 2026 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775912267; x=1776517067; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4g7ZWe8WPifH5y5coO8dt9KUB40+ANDdk64E/1BJRc=;
        b=XM/BJqDz/YPtczgFr9KUtpv5aa2GIXR3Oot+qWKa6K3KJZGvQ7461uztqrCr3ytV5s
         XDOt1uc47ca6g07SMoY+VSJLkNqxbzgV6b5YTOJzLP0ajDN/l9b/Hn8wFpnruePszJlT
         98+0GnOZXsv7NnKKV700U8meq+zjwYNbRXzjEiIQPXLxwcHuwbCX1ub3GSchLfFq21fg
         ZoJHFu0KX+c/uMZM3eEd2sNw55Ov4A7GceozFlmlqHSpCUE5eftQiOfmyM++LvwQ1BFJ
         U7fWEUd9kB52Sl3/yxKdAL2yRO5N7ipY2RxXYgyz+LQCwkEomqPlKQiON5GlwweT7hl+
         dPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775912267; x=1776517067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4g7ZWe8WPifH5y5coO8dt9KUB40+ANDdk64E/1BJRc=;
        b=I4sneU61IYfYyIAOp7dtC0o6Pp22bl+L7gE43Xv0jD6CwQIir/Ko8CkJR3W5B3wROv
         lpGXfVFCqmwIu9CSsgRqnGoWF5u6h5uKt1Zcg+d/fu9Qm0fDWDW8lVRUl/8gvdvTexeO
         S2otodKYB+eOA1r6rh/JHNSDFtPs3uyJcYgWpc5c3q3kwjJi/gtCGrCQCsLKEjrEHD8A
         cpAtXAq7O6M+lBawikeMXyqoCngMbPvjhSzbwtSPP1nNbDlPpOeGzJKo+lJVsLSEz+n8
         dqzprpibGAsh0wlF9OjV8WI1SijS1l5OQlchem6rMqxh21jmX5s6jpjUy58drv0CNdkz
         eOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV11Txla9xkzHkYy52io8qqN5WCwN3hiKF+18+fujmDQ8XsEuOC4hqZ3Gwz+kIp0DyQzq99SqT6s6U=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3c/Bt0SvUm2I9rO3mpkaMdkzHmKUT7ciPyrCXJ9ZlOOo1t3Dd
	6umP3yDVihrz4dnzITtANpwGzO4jpjH/rfSkMHEy5dWxWvB5Cj6+w30A
X-Gm-Gg: AeBDiet8Kxp/PsqIiamCtEosEMCH0Yz5iiMfgO/L+Ro3+nfTE6ivTBdxUskRrVQuHYv
	TgARZKCsNIhc3ydCqHiNERdZAoaNchvLXxZrylXVKjow7DCHU1lZEEFo6hxKpbHCTc8eW/KPv84
	ZJM64D2F4D/eloIjZVGdxtnKvqdMfOhUTWOLTT8uiOXWPiwz5QtpvdmIIDQOi9uAMzsiL7Aq4wc
	tVX1ZHKFsQCWytT8RPR+Qz2H2dAWT/rFXCwmzQLYjFVsLr4VNdpEUC85nrmamvs0fgiv6isOimc
	hpw8KmD9LI4C268yzjYH8N2LnWHTwfJbHT8DVl7BrxbMcSlSXochKExdfAO/Vg7xvTJYkH3qd4s
	LsK+PYRr+1xVqWo4H58fb3fNBXtSZxVRTOMAbtFuDugbIBSm4A+ypOce6J9bR+a7hnnd6xxhdNi
	clzxL/c3ydnxyXdzsVHWm6KmL84SRL
X-Received: by 2002:a05:6300:8e10:b0:39c:787:f185 with SMTP id adf61e73a8af0-39fe3f3fb2amr5468289637.29.1775912267096;
        Sat, 11 Apr 2026 05:57:47 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:4440:b527:db2e:c93f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b6dd7sm5905837b3a.29.2026.04.11.05.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:57:46 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:57:42 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Kick idle CPU for
 pinned tasks in scx_qmap
Message-ID: <cpn5bqvb6qmew2opqffmtmgcuin3lvtiqzht6vmnef5px3pvr2@bhgdpcfcmg3c>
References: <de52a1c5537e2a130d19eb244b7606c1@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de52a1c5537e2a130d19eb244b7606c1@kernel.org>

Hi Tejun,

On Sat, Apr 11, 2026 at 01:33:56AM -1000, Tejun Heo wrote:
> scx_qmap uses global BPF queue maps for task dispatch. A task pinned to a
> single CPU can only be dispatched by its home CPU's ops.dispatch(), but an
> idle CPU won't call ops.dispatch() on its own. This leaves per-CPU kthreads
> like ksoftirqd stranded, causing NOHZ tick-stop warnings from pending
> softirqs.
> 
> Kick the target CPU with SCX_KICK_IDLE when enqueueing a pinned task.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  tools/sched_ext/scx_qmap.bpf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index f3587fb709c9..09d1624fb869 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -314,6 +314,14 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
>  		__sync_fetch_and_add(&nr_highpri_queued, 1);
>  	}
>  	__sync_fetch_and_add(&nr_enqueued, 1);
> +
> +	/*
> +	 * Kick idle target CPU for pinned tasks. Without this, the CPU can
> +	 * idle while ksoftirqd is pending in the BPF queue, triggering NOHZ
> +	 * tick-stop warnings.
> +	 */
> +	if (p->nr_cpus_allowed == 1)
> +		scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
>  }
> 
>  /*
> --
> 2.53.0

Looks good to me! The same issue exists in scx_userland where pinned
tasks can be dispatched to SCX_DSQ_GLOBAL without kicking the idle
target CPU. I'll follow a patch to add the same fix there!

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

-- 
Thanks,
Cheng-Yang
