Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A8B2DF13E
	for <sched-ext@lists.linux.dev>; Tue,  9 Dec 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765319772; cv=none; b=LHiSfT+Y8bBQGTpEgxympQ57P3ZP6OWwe5DitQo0tRjXzkmpTMm4/6wpyGxiZJ2vQH5Z9hEda02Eb3hnZ0oiS73qKY/5cmXZ3UtFaShozX/XWbF92dlkNGaiBY6sbq1jEqH+Ad7h/8J2HCvEp1sDz/4MeDrX6NpFqUAtcdFv1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765319772; c=relaxed/simple;
	bh=1GfgVhapWgGpkPQS1glpXT8EeTUtczYpWBuPImq24Kc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Ft5wORBbBxuXlHErgV8yDBJEMFYlTD1jbX4mkHVDG9rZokLmzAa3su41IEoy/5VepK3Eoe7PcVC//99Zp2Fh9qvPvlAuRt4nkyFtBkpDeqJj44ZLRhI4Z74qWpNkJ01TiVXVtqp4F4C7qdH4iQRhQbhO7a77svrYmj+ncLkaKJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=bDVfeWaj; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="bDVfeWaj"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2da83f721so35471085a.1
        for <sched-ext@lists.linux.dev>; Tue, 09 Dec 2025 14:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765319769; x=1765924569; darn=lists.linux.dev;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMDjrbgm3fd7/vhfQib/L2JYfPytQjquusIcJU5ydyE=;
        b=bDVfeWajs/N8dwtJG+wWjVwAOeOC+1ovCayvQcy2gLgoOoflfLTFWN+8RCIP8FY1LI
         YKnmxNgrvvTH2OSj1n/ahIe2by+VEqtrnt41d8Oaorzi3sCjumUeyv9K7tEwUEo6dTju
         9scYVWp64fjn0aVDzY1EI/7ICfDDtgXXmL6a4l68FTPZJ6JhoD5Z81Y4S/T3xAvpZGV8
         oCqBgr+cF7+sTtVnBHJeWZpPrHut4hLdtEjAQFIUA4eIPSw7sesrivq0AJ/IPo7VX2/4
         ygtQsfPJ0ySzRiT6xKikAW06//CK0YyjKOIYaClD9XxVNI5XOwUh6MCZe7P0LI5gYIE4
         nD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765319769; x=1765924569;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMDjrbgm3fd7/vhfQib/L2JYfPytQjquusIcJU5ydyE=;
        b=G1CvMKLI2f4xzetYCTutD9nAj3DltcXpBbMVi8RZyYdB/Ha2E5RLx71p9yBbE0lUSJ
         8Wh4ADYlGQ4aAoZ++/9Sot/KCIbkXoQH4UImFheW/Nv/soB6qSaaxtsC//VME5iarK/B
         ETplSiQyxe9Xn59YgnB5HqlpuFELDIGvka8N88UIvipGYG2H0z5/tqiHQytWrPZO80h5
         WZQfZyl+ZO/bWFbBxDs6nl07tVKbq8waPF6aFSJCfzAz5PWPnFGe9fFLl+zjX2YMMiw7
         rc3Z/HVto9COZio2JawI7Vf+AnVGqcqH3IM6kcvHkvT2uAGVx2XbE5X4U98/a3O8Vrjx
         fyvA==
X-Forwarded-Encrypted: i=1; AJvYcCXmA6tDF5MKYN8GnAYUv1ZF57yJ+dthOelMsBggl1Dux+vD6wvn+Z1adZ47a3ro3DOOf34CYRIgi5Q=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxeaaxe04fHnyz70vg6cR68OINALiX6tlcfEoZrQfrF4xjgayOJ
	3DW/XwBi/TC+P8q1F222IIlJ/41AbOfM3tmxMntGhg3r3iseBI5ovisiZzMp5+B96UI=
X-Gm-Gg: ASbGncv/QlWFS/BRqqdLONlKlY1EbcrKqqi6U4s75kT07E/0XbDF3tEI+b1ekLMqzay
	p4cKLl3CX0OxXEkYOlJRMrX9FKBZCCvritMp3EUxp6e1IQrO5d6fTpEo+Yf2nY6OiIo4pmirxoM
	q1HLIu+UO1ooMhVqj76BqDx4qVvQKX2ISiZi1ykamacc5m4/n/Z4dFUkBultCS/lCglrTl0+hzz
	lzfn31ixjoKf4Ojmi+V3oaamkGcdkcS+WZTFGeZWp1NL2EPr1vR056wjKhlf8elT+kGiszs0Qzo
	7/LZa0JQakULU+unyCgML9LBDsloljss0Px0tmKTyCdBQZywpMwsBsxLWq1Rv7LOYjEUYpLo3X1
	A51XeljwxDmPrieHk4INf3Ca3fRgFvl78kFb9AjVeD3I3GLrA5ljtPu0ew77Uf1o/iyGwc4hfLh
	RefMEoWN9B+jU=
X-Google-Smtp-Source: AGHT+IH1jG12E5R/nTMy7dymzHYKkpW1KBjpQvlMRwy0j7dR++9cpTTnCImcH7gDvx5+yn0+N/TlWg==
X-Received: by 2002:a05:620a:290c:b0:8b2:9b48:605e with SMTP id af79cd13be357-8b9cea84f9cmr416559885a.38.1765319769122;
        Tue, 09 Dec 2025 14:36:09 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ba52550233sm2700885a.14.2025.12.09.14.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 14:36:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Dec 2025 17:36:07 -0500
Message-Id: <DEU1MPG44IHN.LPC4M5HCMXWQ@etsalapatis.com>
Subject: Re: [PATCH sched_ext/for-6.19-fixes] sched_ext: Fix bypass depth
 leak on scx_enable() failure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>
Cc: "Chris Mason" <clm@meta.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <286e6f7787a81239e1ce2989b52391ce@kernel.org>
In-Reply-To: <286e6f7787a81239e1ce2989b52391ce@kernel.org>

On Tue Dec 9, 2025 at 4:04 PM EST, Tejun Heo wrote:
> scx_enable() calls scx_bypass(true) to initialize in bypass mode and then
> scx_bypass(false) on success to exit. If scx_enable() fails during task
> initialization - e.g. scx_cgroup_init() or scx_init_task() returns an err=
or -
> it jumps to err_disable while bypass is still active. scx_disable_workfn(=
)
> then calls scx_bypass(true/false) for its own bypass, leaving the bypass =
depth
> at 1 instead of 0. This causes the system to remain permanently in bypass=
 mode
> after a failed scx_enable().
>
> Failures after task initialization is complete - e.g. scx_tryset_enable_s=
tate()
> at the end - already call scx_bypass(false) before reaching the error pat=
h and
> are not affected. This only affects a subset of failure modes.
>
> Fix it by tracking whether scx_enable() called scx_bypass(true) in a bool=
 and
> having scx_disable_workfn() call an extra scx_bypass(false) to clear it. =
This
> is a temporary measure as the bypass depth will be moved into the sched
> instance, which will make this tracking unnecessary.
>
> Fixes: 8c2090c504e9 ("sched_ext: Initialize in bypass mode")
> Cc: stable@vger.kernel.org # v6.12+
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>


> ---
>  kernel/sched/ext.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -41,6 +41,13 @@ static bool scx_init_task_enabled;
>  static bool scx_switching_all;
>  DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
>
> +/*
> + * Tracks whether scx_enable() called scx_bypass(true). Used to balance =
bypass
> + * depth on enable failure. Will be removed when bypass depth is moved i=
nto the
> + * sched instance.
> + */
> +static bool scx_bypassed_for_enable;
> +
>  static atomic_long_t scx_nr_rejected =3D ATOMIC_LONG_INIT(0);
>  static atomic_long_t scx_hotplug_seq =3D ATOMIC_LONG_INIT(0);
>
> @@ -4318,6 +4325,11 @@ static void scx_disable_workfn(struct kt
>  	scx_dsp_max_batch =3D 0;
>  	free_kick_syncs();
>
> +	if (scx_bypassed_for_enable) {
> +		scx_bypassed_for_enable =3D false;
> +		scx_bypass(false);
> +	}
> +
>  	mutex_unlock(&scx_enable_mutex);
>
>  	WARN_ON_ONCE(scx_set_enable_state(SCX_DISABLED) !=3D SCX_DISABLING);
> @@ -4970,6 +4982,7 @@ static int scx_enable(struct sched_ext_o
>  	 * Init in bypass mode to guarantee forward progress.
>  	 */
>  	scx_bypass(true);
> +	scx_bypassed_for_enable =3D true;
>
>  	for (i =3D SCX_OPI_NORMAL_BEGIN; i < SCX_OPI_NORMAL_END; i++)
>  		if (((void (**)(void))ops)[i])
> @@ -5067,6 +5080,7 @@ static int scx_enable(struct sched_ext_o
>  	scx_task_iter_stop(&sti);
>  	percpu_up_write(&scx_fork_rwsem);
>
> +	scx_bypassed_for_enable =3D false;
>  	scx_bypass(false);
>
>  	if (!scx_tryset_enable_state(SCX_ENABLED, SCX_ENABLING)) {
> --
> tejun

