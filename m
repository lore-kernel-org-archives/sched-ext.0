Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D0350D57
	for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341588; cv=none; b=faz8XukaJ4QTedC1vohaILpSB3+m6gLCMV7W34R0dwcoqQ2+zpCI8C861xj4AQhel0p2K3kEri9u7CV2+q4XF7VruDVsz3Um5cID/6jtgFddogVM7Utb7ySM3AlMQQ6WjRm3m2BCHISAY+/Dp7NUV8yT4YlLxgzAn2Na2u95W5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341588; c=relaxed/simple;
	bh=JMKPIWgq8b9DBCFSMppOOhRohcyexWNss6iyCclDIgo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKPTFiA4BmBq9BvldLqqZdhQm+xl/ld5Tr4Nz3hgyqfIFzZlgq5hcQ3+p7ILaeK1H5ja1HQTJwDo8lMDQIhg8TdpKh75MImmidGAYWGPFYle2vVyDnRfC9KBrYZ55fxC/mmp7TU9QWBk+jU4eEtjdry+kEz5TBmfJHxi0P1adwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWh1lKi9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWh1lKi9"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso122450a12.1
        for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 13:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768341587; x=1768946387; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JTlRjbsQTQjHMPHLzcQF6C84Ga9JaD/ogkGGtY0cAkU=;
        b=gWh1lKi9ncxWMNZ6BbdUOJkrwymw2j8VamsQARh6acA4W8TJyajDa7MSyRNuc0Gyz+
         JBSSHMXa/YXrnahgoy1ZYqL48XfLioQ3mEnsZu8ZTgK1+ygWFv87mVjPVPgPLEoXz3yO
         m7w3Amu4xs/jlNbLZATaNxGbvhVnI7WZieRcYJfghB7r/Rm7Ng5qyusUh2ed01GSCaLN
         ZNKuXvqKQlLPSLf98VG+Wiff6EswRHSod7VfX/LgvPcK5s3uSlgC7WJBQIJyjOcurztx
         wp8FlYSma3nYQtcSjOyGOTpEHXnUPk/kR5p3V0t9niYWWV1M7wb3MlcjsInr4Kj6baWi
         ptAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768341587; x=1768946387;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTlRjbsQTQjHMPHLzcQF6C84Ga9JaD/ogkGGtY0cAkU=;
        b=nlOG3IpGwzkefISdXJ0EI+CMZYinsH/IJ09UlR/7Tt4gEDj6cXrk0rHUJ3DVP4nGX/
         O7ym11oiNJvUA6NgUnwx6Ydws5XQsm+YBc+XVTXelOvL/Luy8oplF3xwp9ke66GPkH6J
         sYvTMqg8WzWutXzV6rU0m4a7/b15Jh9Ga9gCxrS23Y+N7mZRXWT8n+B+6emIBfDzOEsJ
         q97SWAGTPIwsSttSwBH41U1i/qkvapNzgNiR4vWNinCFyUSM6jlp1sB6Pd2iI9MYx6/j
         vE7aFH7V0amtugrKQ7u4V7pcWJCZP2nhVaJ/dunpgcQBhKf/0NSocpXn403yyaClko45
         wmbw==
X-Forwarded-Encrypted: i=1; AJvYcCW3dkjK0sbCUs0prBlaVCLkcDCv05sMjGuoGLH/oEq+k0AD5ztJ/Slm7oYzWpoZ3FFVIVFPtbfeD+o=@lists.linux.dev
X-Gm-Message-State: AOJu0YxmhBcEolZML7S/6/++NuSKOXczCk7fRVXFda+zdheVZKyKSI2I
	28nDIKLhzm9xOne9Q+aZLQSuNfdVc6VqSZeMjyNQ5+iiLKgqlg+Conav
X-Gm-Gg: AY/fxX5HGO1XV0Y4NPl0jxDsfYO17WU5sgu6eC4CIHFUnwd7/kPdxDQfFmKDcIXqAYW
	Y7IL6AppO8EJoofeJJK5QbcRIBQo+1wMHkR86RwysjI+roB9GKIO8DYchDihwT057JUzqNdiHxw
	JmS8Ftt2N+fvGzF+yzKLyBDtUG7riebARQNMioRnNZ8IAiQ3F36/RSsL9h6tysMBRh/A+tT1xm7
	CN5njojiqb09xrUArK97k6UZoOn9icvx3O1oy8YrcFvVBTdtcXkGyCX7IMpy9fZQ69ScAMlFUf8
	GOoSREKvxZoDuSjhFDK9YyqpXKBclvGfDkA0zPzvbQr0e/d9k89h6nCWj3K5CebsqLjatZAfhnD
	rzAic5zTo3LrZz5epSB7bHQVh7pF+292ZX41vimv53L2ohHFx20hHW34VLe8uhsn8flDxyeseQv
	b45S6dqUYJsUW3Bmn5cjUbuDIJGZSWpSj2uhx12qrSgQkiNbcWVv4=
X-Received: by 2002:a05:6a20:2445:b0:384:f573:42bf with SMTP id adf61e73a8af0-38bed1c96b9mr512725637.53.1768341586883;
        Tue, 13 Jan 2026 13:59:46 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc05cd87asm20802106a12.15.2026.01.13.13.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 13:59:46 -0800 (PST)
Message-ID: <18d9b15319bf8d71a3cd5b08239529505714dc96.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Tue, 13 Jan 2026 13:59:43 -0800
In-Reply-To: <20260109184852.1089786-4-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
	 <20260109184852.1089786-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:

[...]

> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3271,6 +3271,38 @@ static struct btf *find_kfunc_desc_btf(struct bpf_=
verifier_env *env, s16 offset)
>  	return btf_vmlinux ?: ERR_PTR(-ENOENT);
>  }
> =20
> +#define KF_IMPL_SUFFIX "_impl"
> +
> +static const struct btf_type *find_kfunc_impl_proto(struct bpf_verifier_=
env *env,
> +						    struct btf *btf,
> +						    const char *func_name)
> +{
> +	char impl_name[KSYM_SYMBOL_LEN];

Oh, as we discussed already, this should use env->tmp_str_buf.

> +	const struct btf_type *func;
> +	s32 impl_id;
> +	int len;
> +
> +	len =3D snprintf(impl_name, sizeof(impl_name), "%s%s", func_name, KF_IM=
PL_SUFFIX);
> +	if (len < 0 || len >=3D sizeof(impl_name)) {
> +		verbose(env, "function name %s%s is too long\n", func_name, KF_IMPL_SU=
FFIX);
> +		return NULL;
> +	}

[...]
