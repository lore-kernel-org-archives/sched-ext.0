Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5E37C11D
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941551; cv=none; b=bsDKZcj9YNc6buvzmN5umMrQbCSqf8kx+tAzfJl9lHIc+i2Eou32WoVXCOZ5JK4VWeLiAsD8VNko16jRrEr43he267f36LICRgQMd+0omhzWJObSiV3cTfO6BUlIdlPTII8hDQeaRchgvkz7L+GjRfbTkbzHNENJ6cWIXWthAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941551; c=relaxed/simple;
	bh=wq1Cu8bZXdxkc1IEjaOXG3kJSBniOcazTJJjusnkaCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz7XIGixFnK4vZl4YNWr72PiZkWpj0WAQYfWfcCMX7EUJBUm7fuaZx9+Vy8uU07WxIkj9hfojp/brlKqIdsjAQTVvpp1vfdufei1oe2SQtT5ss3S+DwHQwB5BmiCM5RH+wJKAiIyzDOnQWfubzfkaUIzykMwc6Cd/SS7bM8sIDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ8Z2VnN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ8Z2VnN"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35691a231a7so4462564a91.3
        for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776941549; x=1777546349; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeNLLevQh3pBYAO6lXAZTdw0TrOMFI6h3YnGdTBUiYQ=;
        b=KZ8Z2VnNfOyqQBrok26wPoS9ry83jUpl1diJieGsG6mcJUiyvghhWsvZPXy9ddKbZs
         /hxUGELUIyYRgsS+wMkFo4csinlli+6cvtE/pUACIljtPxKDL9+4kEKU0Z1WqKi/0iRU
         t0RX9KgVqjNdwQpLyhOGBf3HpMoCcZsNb+xe3utsiOssKnhWRea0WUcVDShX0zP6wiIW
         T5L4I65d+8T/XvSG4dneb98UDnTNxq1v+qvwSrBjpoIWXX+FP6GXm2GT74pa1S3wke57
         H66TkspRYU5uTssrBfk3Y8AkPAnS62IgzmGyfTWLe2KpqODwTK9iSmUvTiRR9Kd1zeK6
         83Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776941549; x=1777546349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeNLLevQh3pBYAO6lXAZTdw0TrOMFI6h3YnGdTBUiYQ=;
        b=QrEUJcVMxikGfOVlXazUss11zhcaEC+6iUQVzDjU2VBnJS4vf+snGi3GyrNyUnBpjU
         zHwC0L89ofLT77YXLBfzr50GlncodsUDRkzj8/Aiq3gGPWURoTTO4JFF0eF4k0wAmQy0
         K5JfmUKNJtJBNroNCGOwn6REKRxCnQrmqHWMrPLhz1OcSijtFVeYcpzmTR1HZq0aX8G2
         Z1IkElHMQHQHvcG3y/dXVYoFwPYdAYh2lGBowL2ruTjoD4Ja8MmHP0HWZHdtiNp0roNO
         DZqx+W5jcF3TnlwHb+EwTcjEmh/srpuSI7XHnvEJRfY2S180O/kmNroZ1r7EXjk94ENd
         ZaeA==
X-Forwarded-Encrypted: i=1; AFNElJ+QualnqUHSwkqOobtUsyBfxT1JfjzvqL2BCjjFjGDD/o4Rj2wzHzYJnKB1zybvtE+kuCwfzbjbDgw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxR+11vGQ64niNycwvJqJ83KZ2azybEEbzwEiJ0dLCLwI49uwtR
	QisYfCJM2+BOaIct2hUHeTMsIbfnXGXDB/EwICpYah/lvTAwdR8fBKbs
X-Gm-Gg: AeBDietT+TRqFtTBVvjZHZfT7ZfSReOXPh3MFzTv2pVczZeWAFycQ/E/sIEsDjmXT/Y
	F/SSm7FTT0AkgsJd4VyLyYnxmZ1vV+iTTHd/34diZe/YiUGEXVSypP7mDck1egNPJpej1kl93Qs
	Iis5IFJpsn4DeiuWOfPtha+fiaNLkTnECDn1BQIAtNTUlpTceZff2Ar4NHRQrCtPh6s9MHoobPh
	98fXTzWsKvSoh+hoRafnSXS5TmRpqca21wj4dZfKvJRPIAoBN0k6IQYSp2nYjgOdKNfZ99jtad1
	/sLBGL7XwmBKvQ3I7KkU3wpdZbEjKUleiK+Lma4NV4Q+hAafraL25S+BDetBe6kP5gY27gO9d1D
	7pgG2QMFJ+KKXuS/Jk48NAtVmaKgYLa9IrM9kHLucGDRtPzb9MmkhlClMPtQrcy3dEG4Q7CGz8P
	3I1XVkbV9y13juJgMQeWU59IO6hF6+Zn7jhx6Ia2lMkyFAUAewYcIOpH0S+dJ4Q8i/G8AA7pWyv
	DPxfvl8BJnFlNXa
X-Received: by 2002:a17:90b:5544:b0:356:22ef:57ba with SMTP id 98e67ed59e1d1-361403dfee7mr25650866a91.7.1776941549066;
        Thu, 23 Apr 2026 03:52:29 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-83-234.dynamic-ip.hinet.net. [36.225.83.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614189343esm19666810a91.6.2026.04.23.03.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:52:28 -0700 (PDT)
Date: Thu, 23 Apr 2026 18:52:24 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Zhao Mengmeng <zhaomengmeng@kylinos.cn>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] selftests/sched_ext: Include common.bpf.h to avoid build
 failure
Message-ID: <20260423184955.G2144@cchengyang.duckdns.org>
References: <20260423-b4-selftest-fix-v1-1-8c72287bde3d@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-b4-selftest-fix-v1-1-8c72287bde3d@kylinos.cn>

Hi Zhao,

On Thu, Apr 23, 2026 at 06:42:35PM +0800, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> In scx-cid patchsets, sched_ext selftest failed to build with following
> error:
> 
> non_scx_kfunc_deny.bpf.c:17:6: error: conflicting types for 'scx_bpf_kick_cpu'
> 17 | void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
> |      ^
> tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: previous declaration is here
> 136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
> |             ^
> non_scx_kfunc_deny.bpf.c:26:23: error: too few arguments to function call, expected 3, have 2
> 26 |         scx_bpf_kick_cpu(0, 0);
> |         ~~~~~~~~~~~~~~~~     ^
> tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: 'scx_bpf_kick_cpu' declared here
> 136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
> 
> The root cause is on scx core part, but we can avoid this by including
> common.bpf.h and remove scx_bpf_kick_cpu() to make it more robust, just
> like the usage in other xx.bpf.c.
> 
> Link: https://lore.kernel.org/sched-ext/20260421071945.3110084-1-tj@kernel.org/
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> Tested-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Thanks for the fix, LGTM!

> ---
>  tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
> index 9f16d39255e7..0d6fcc8e5eb6 100644
> --- a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
> +++ b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
> @@ -9,12 +9,7 @@
>   * Copyright (C) 2026 Cheng-Yang Chou <yphbchou0911@gmail.com>
>   */
>  
> -#include <vmlinux.h>
> -#include <bpf/bpf_helpers.h>
> -#include <bpf/bpf_tracing.h>
> -
> -/* SCX kfunc from scx_kfunc_ids_any set */
> -void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
> +#include <scx/common.bpf.h>
>  
>  SEC("struct_ops/ssthresh")
>  __u32 BPF_PROG(tcp_ca_ssthresh, struct sock *sk)
> 
> ---
> base-commit: eff158514a85c1b81966667a880dd8bcd29bbbd1
> change-id: 20260423-b4-selftest-fix-d87cdda6185e
> 
> Best regards,
> --  
> Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 

-- 
Cheers,
Cheng-Yang
