Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11A32ED24
	for <sched-ext@lists.linux.dev>; Thu, 29 Jan 2026 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707308; cv=pass; b=DcwXGT6H7YI8ZBPT+mlpkPOW7xZwS2y+cJ9c+O4NE2C6Dr6ZS6h8qNi+9umkqEOEaIiy6ezy4mvKR22vCSQh1hsD+eNwChnuNP94O6Sy2ozmCByGsbuPk8m1m+lz/wmtpLpTeS+Tk4VErQO3AptgpA8BwIhzTiKHw5hQOQ6+MEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707308; c=relaxed/simple;
	bh=B/Z6oc7nhVZLZTSl8l3OJXcNI+VHpZ9v5E73ZIi4/a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5utKvrY6JQ1DiY8muApLVAATWTnf0kmSCfqASTxo0CARWfu8A7wGJ6gKsJbp/eW7xJK0IQlrZngJxBpbDSNxJzqejatCeTGM0J93vNoGEABd6dcdhatvGnJZoWusiKUobr+YbIE2569SrdfC1bXKeq6NokfUEUt7xgpLaXZHZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbIk40M0; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbIk40M0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso7534625e9.3
        for <sched-ext@lists.linux.dev>; Thu, 29 Jan 2026 09:21:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769707303; cv=none;
        d=google.com; s=arc-20240605;
        b=SkElxstHs9D4OzfvNK+OBajrBqZH3pSKDgR0ay30/eUXk16JAbn3LO4pkTr1HdOpwr
         G+CoPmtgQkkTGQF3/ccbkx4kgwzruHvBCzKo33b+HRUplqYtylC6bPFV8SipgFLED/Nc
         CM1HBhCz0RBmmJtZrXPtjK9RLjENfXczKqgYmv8sq9KBQOTddGHd25BCg9K/zQK1KgI0
         1X2plxJv8eTNS4sSzCXEhwxBNRMJmjDCuL5Di7RKVdQe2MkKhTVOjsWaGukWeuxXFiQH
         qEw3GZg2fRyw6G1Q/DDGtZBodUPlIJaFUCvTEcGxCU7L1XMEheSpTTdrhN8+iUYF29wZ
         IEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cikD0DW64ATmIS3V1f2k1Y72bgL6wosY2UHz3lIPFuY=;
        fh=5e7hsXP1SPcYnpqU9oPS7kvpQRG4FQpwjdOnkY1ShwU=;
        b=DeKIOIkFSx2b9ftMimsJHwCscawNdUhs51R1pCI5ZQTUSIuBZaIB/rx+wYTg6VPly7
         Lh7B1JGst2x5W1IQotncPbs66yttdrbvwtcisMJ1XBK9BjyzppptP5LpWlE7VqJ6GzYk
         ZDd3VvhEAxEEIPIQzlBSBq3a69SI1LDo3HKk5n8ULYpupUjWWt/eD4dMIEP9Rch0nP5Z
         VpKWBWWNfLPCm7F/dnDTv9+ek5rhjouxELwhJAaRfNaOsC4MAtoUlSxY2uEnGsQPexx5
         8alo8Xsa6YlksXeIG04vhheIA88NEUcsZKZ4VheY9ibRto1sIsEzVkfqzQsw4oz/WRnI
         bH/Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769707303; x=1770312103; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cikD0DW64ATmIS3V1f2k1Y72bgL6wosY2UHz3lIPFuY=;
        b=bbIk40M0hSwJthY+oWTD8SKTpUdr9kj8pqIXFMvkO7ayxMhUiGOTxFn0VrsVKRa2Ui
         xnidePTfpyZp8fvPw8aX+desDduArTk6vja0RMEQU+QrfUy0RJtSouVNA2LfKmHrTwdo
         O4YVuUmKEtPuxf0V6aPFOi29s8uBLWL9JxQvLFI4vsJRSW5yMY8iZYLHYNJAC5f96s0t
         OaLecwu8zUW3UXLqV6WNvyWPSydqqwvcY25xXsCOTHpNBmtEZKwraPOJqeNPBp9rEjUZ
         ZevLVmvwyhycwepkXdqT4StkNz5kfed+FHkTfLG5cCh3+QbmkTwCtp6lTj3c54Swl8v9
         s6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769707303; x=1770312103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cikD0DW64ATmIS3V1f2k1Y72bgL6wosY2UHz3lIPFuY=;
        b=HlEaDU/8MYo69RZh/tp9nlzmD+j8RacgHPq9k0IYRh+2BJgShtF6tJ6jSIFNGDBZVj
         AF95Nnt80mafy59upqodMQWfqCHeGbEprnfJwtvP25rvb/yqdmnwUGpiuMwNMQ1SodFe
         3ZaP1RsaeI6W7JCRW+ZEXbPKdfWRYM1e5fv4CkDnbJSuzPfa4m2cTRVr0izEWQw9ccXf
         VW4sMQ8HocbmrYcgV6VST+4fxZl/YPw1qOkLjuWQ8swCbM44w/0hOXCRJJ6S3U3Pjr/q
         zvDnZb45T0vbBCNvHgwzuhBD+nCXs/MWlB5hKz/z17E3M2UnV4GAajV6N6soVWQ7aMsT
         68iA==
X-Forwarded-Encrypted: i=1; AJvYcCVSxSPZPGYTpb/q6w6nwQIM1fKMv7/9KkfvXJEB4L1oHUkK5CBNWfA+ouOn3marAhxGZxsHSz8/948=@lists.linux.dev
X-Gm-Message-State: AOJu0YzkDF2umRMX5xe972I3yrXpiLHm5GoqvEA3ZI7YJD7mn3JGf41s
	5aIQEYNzeXiz55HdJsxNE/ZOz+4D3romx8kSmTA1zMYrYVSKPvkHap8jaabd4y7vrF9vm5ZrvSl
	cFI/8TJE5MlBaHQPzNy7TOr1mGMcW4aI=
X-Gm-Gg: AZuq6aKa1ln25PJXbrznrFcOtFB9qMzqgh21SKDp+CRlmqC8LiOuEbbddRLGR7ecuHD
	eQNyBCcQu1ETX4NY1TyA+7RJdvKa6BAgU7JqU6K4K1pNRKvAx9xIatpAn1jplz9D1Vum53NiA+F
	ei8KLg3XoB0qBA2+MBM2sftvOaHr+lZNYbLHl3oH/l+QVV3CGb7RGsv5GaTHn47rFGK5gHfsm1L
	mQ6Lgg5zKQsgY5txw7KEu1/Lep0j8RSQsnNFiA6VHSMkJPZOYqeGWHfb/j1WG+z7Cgdhmhdtzld
	AZGh5Jck27DtR3ecC4rHJSyyywKWkRKsq4kHzfvko7n5dmcQQC89qQ4WD/U2TBcD5fUMoh7a
X-Received: by 2002:a05:600c:4ed0:b0:480:4a90:1b00 with SMTP id
 5b1f17b1804b1-48069c69584mr116465305e9.20.1769707303333; Thu, 29 Jan 2026
 09:21:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260129135426.93424-1-changwoo@igalia.com>
In-Reply-To: <20260129135426.93424-1-changwoo@igalia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 Jan 2026 09:21:30 -0800
X-Gm-Features: AZwV_QieIcsJO1VA71VFB7TRPCNl-paSdxCtbBMb_Zd5Q7mc_krsW0CoTdbFns4
Message-ID: <CAADnVQL2huFSNAn4Pkbx2GOqAB=Z-rtd+Fp3BnJTZ-tbzOhgmw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Make x86 preempt_count access compatible
 across v6.14+
To: Changwoo Min <changwoo@igalia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-dev@igalia.com, 
	bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 5:54=E2=80=AFAM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> Recent x86 kernels (v6.15+) export __preempt_count as a ksym, while older
> kernels expose the preemption counter via pcpu_hot.preempt_count. The
> existing selftest helper unconditionally dereferenced __preempt_count,
> which breaks BPF program loading on older kernels.
>
> Make the x86 preemption count lookup version-agnostic by:
> - Marking __preempt_count and pcpu_hot as weak ksyms.
> - Introducing a BTF-described pcpu_hot___local layout with
>   preserve_access_index.
> - Selecting the appropriate access path at runtime using ksym availabilit=
y
>   and bpf_core_field_exists().
>
> This allows a single BPF binary to run correctly on both v6.14-and-older
> and v6.15-and-newer kernels without relying on compile-time version check=
s.

See.. with bpf approach instead of kfunc this new helpers
can work on old kernels without backporting kfuncs :)

> Fixes: 4b69e31329b6 ("selftests/bpf: Introduce experimental bpf_in_interr=
upt()")

fixes tag is not appropriate. It's not a bug fix.

> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  tools/testing/selftests/bpf/bpf_experimental.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index a39576c8ba04..0194c0090e50 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -614,7 +614,13 @@ extern int bpf_cgroup_read_xattr(struct cgroup *cgro=
up, const char *name__str,
>
>  extern bool CONFIG_PREEMPT_RT __kconfig __weak;
>  #ifdef bpf_target_x86
> -extern const int __preempt_count __ksym;
> +extern const int __preempt_count __ksym __weak;
> +
> +struct pcpu_hot___local {
> +       int preempt_count;
> +} __attribute__((preserve_access_index));
> +
> +extern struct pcpu_hot___local pcpu_hot __ksym __weak;
>  #endif
>
>  struct task_struct___preempt_rt {
> @@ -624,7 +630,13 @@ struct task_struct___preempt_rt {
>  static inline int get_preempt_count(void)
>  {
>  #if defined(bpf_target_x86)
> -       return *(int *) bpf_this_cpu_ptr(&__preempt_count);
> +       /* v6.15 or later */
> +       if (&__preempt_count)
> +               return *(int *) bpf_this_cpu_ptr(&__preempt_count);

please use bpf_ksym_exists().
It helps to catch missing __weak. This patch adds it,
but let's demonstrate best coding practices.

> +       /* v6.14 or older */
> +       if (bpf_core_field_exists(pcpu_hot.preempt_count))
> +               return ((struct pcpu_hot___local *)
> +                       bpf_this_cpu_ptr(&pcpu_hot))->preempt_count;

iirc pcpu_hot approach was there for a short time.
Like 5.x kernel didn't have it. It was per-cpu var too.
Pls adjust the comment.

pw-bot: cr
