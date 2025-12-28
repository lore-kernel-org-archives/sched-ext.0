Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78EE13D539
	for <sched-ext@lists.linux.dev>; Sun, 28 Dec 2025 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766887323; cv=none; b=cnjWhuxcSGkAK5azhOzP0Cqs73R8MWNWAdukno8502sZkYLjdBSh3nm3BYRL1srP/stMur3waFdAvL5XNHGp3tZqq2FN3UVGqPkchq/2Xz8MUIJQN47c251XQS87mN9tXSiHouDZzytZhbmt/H5wFEizybX1SocJKuDbpAAxpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766887323; c=relaxed/simple;
	bh=fII0Bdm4FL+a6BLf43uRfKp3TOAlNXLjK8C+g1f4rxo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=oZfC4MSis4CfvGamF2deufJR+jkj1ay79z8bSTdHmUHFUhBk4Dr/sxMtYE1ehNGwrx0y2YsRpZmX6M7Gxo8WWtP4GeWYxkVbCzKGk5oA8qVYKprMRWlmL31q/iLOYAx2EAXq3Jnxxql6H1uvMgtJn3c58fjsHqTEk9aTLIDLA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=cYvJnWLK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="cYvJnWLK"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a2fe9e200so66254476d6.0
        for <sched-ext@lists.linux.dev>; Sat, 27 Dec 2025 18:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1766887319; x=1767492119; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E08Qi45nnhLYuHRRc4XyDtBq02cSbhXY/oXo8DlJ9zI=;
        b=cYvJnWLKNugmj3DG6ACti5LMGm/MAfJ8kDxtXtGSMWTJ1ndFH2MSiECZ9L2O0zpZP4
         lSHD/D4NFqWLo/0AYBDZiheFcZltR+XuRiv8tH0ETxBkjZ3bpPxpNuBY26TT7EcVcbzg
         T/Xfdm2zzher6j3wAfjPlEvNSbwBkp02SY+JGki0kItCKXa8T3WUbOdAe4H4+K9lIDFy
         MUahMkFf1lGyRno6U+62LecddTqd1oX1eG5cdQmYX6Srpt3L/XzaqLUvopgQ99WV0WK4
         cWpMiiFlqKE1ggSZJj8UizMHQDWPwlXUv0avR0OmIlQqQatJShMBWcXgpP1/lu+q6K0U
         8Tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766887319; x=1767492119;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E08Qi45nnhLYuHRRc4XyDtBq02cSbhXY/oXo8DlJ9zI=;
        b=n+esY/aagxeJEPwZh72l+AoI8iH+VZHQTP77Wv+Uu+Ni/Zq/OdZSTdJjuH3PdijyRL
         JBIF6saqxjwvBxTs3lMlmLbaT6FwqMSqzJyCvA8cUsuQHurUvnOUUf5Z0n06o9LcOTZo
         ls4yGKjYok2+9LiSMJ/sUD2D6dRWteFdNa8Z2GS/lsulF9lTEnU2iJOEbj33+dEpEFrz
         uEHJdSEwiT/L5PAWnasZSo3L59d8IJBx7vHqyT3Xw64pYhHU1aGVmVbW2d0A8YB6UhDg
         2rZ6uApWLXvyhMVMseeMGg4EYBZe1UWoJtPWo/U+R12qWxfTjzCfxq9FYoL663Jevckk
         +vrw==
X-Forwarded-Encrypted: i=1; AJvYcCXiyrtemtmja1jb3mGXm7x3IVpnMpMHt4FbJA0Nmh3a+VIMvFFiicKRx8VzTaRKlkuTHpnO8c5R+Ak=@lists.linux.dev
X-Gm-Message-State: AOJu0YyIHfi9Gnoeys6lLYz3HJ/TT9ioKWsbru0Rah7Y0e1I27ykfUOe
	2ecDuIDU5N3BQr2uxKe1aHatrIuWApZeSzYEw88oJpEbNC5a+sT0O5rUxRcBTsFh7TY=
X-Gm-Gg: AY/fxX76HEzI8PCSkgRHU34RG8akmIzIFkCHiCEknGybvWPB2yk5tnXqEbmrKgb2vPF
	UuYm2hTi16Rjqi6T2zpV4it8WILV/fmYGXHWGW+8t1nI84OpQV+PEBEJ7Z04paqlsqx/kEyVyLE
	Aph9yIAQaQhKMIkc9zbSsZ+3LL7rl8Gm1fCMNZ20MZ7AQv5IswsNSV9p5XzoPX/jf03wRwjGtIf
	0u5Rl1KxCnev7Oa93+KMmRFuaEd0BBH+FMd7IcihvXRYVjt09lL1iHYh8qbYrKyxNgxvii+L8hZ
	jud9UgOFKJ4bZo/C4FaSFn5AV4yVtS2uCgKd9JmK1go5rY3/BcuOrX1kNUwAl4XxwCyI0Dw7O4R
	Kh15QWAIlQAIIHoKirNvxOp96HrIOmJqkR8z2DrS+gE+xsy7YH3swiMIcahDvAHSsdCndwXQ+KR
	EGmoQj6nt9RUo=
X-Google-Smtp-Source: AGHT+IFqZBDwG4LzbdLzCGqSnE9+QL1oWgj3ENO58wD+l2SjddMyyDapBCM/rMl4HuZR3cARdHOqog==
X-Received: by 2002:ad4:5ba8:0:b0:880:224e:aab1 with SMTP id 6a1803df08f44-88d84528a09mr422360956d6.66.1766887319356;
        Sat, 27 Dec 2025 18:01:59 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7e8d4sm207989246d6.41.2025.12.27.18.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 18:01:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Dec 2025 21:01:57 -0500
Message-Id: <DF9HA3ZZ074C.2ZOWI5VIQALG6@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kohei Enju" <enjuk@amazon.com>, <sched-ext@lists.linux.dev>
Cc: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 "Dan Schatzberg" <schatzberg.dan@gmail.com>, <kohei@enjuk.jp>
Subject: Re: [PATCH v1 1/2] tools/sched_ext: fix scx_show_state.py for
 scx_root change
X-Mailer: aerc 0.20.1
References: <20251226084657.75567-1-enjuk@amazon.com>
 <20251226084657.75567-2-enjuk@amazon.com>
In-Reply-To: <20251226084657.75567-2-enjuk@amazon.com>

On Fri Dec 26, 2025 at 3:46 AM EST, Kohei Enju wrote:
> Commit 48e126777386 ("sched_ext: Introduce scx_sched") introduced
> scx_root and removed scx_ops, causing scx_show_state.py to fail when
> searching for the 'scx_ops' object. [1]
>
> Fix by using 'scx_root' instead, with NULL pointer handling.
>
> [1]
>  # drgn -s vmlinux ./tools/sched_ext/scx_show_state.py
>  Traceback (most recent call last):
>    File "/root/.venv/bin/drgn", line 8, in <module>
>      sys.exit(_main())
>               ~~~~~^^
>    File "/root/.venv/lib64/python3.14/site-packages/drgn/cli.py", line 62=
5, in _main
>      runpy.run_path(
>      ~~~~~~~~~~~~~~^
>          script_path, init_globals=3D{"prog": prog}, run_name=3D"__main__=
"
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      )
>      ^
>    File "<frozen runpy>", line 287, in run_path
>    File "<frozen runpy>", line 98, in _run_module_code
>    File "<frozen runpy>", line 88, in _run_code
>    File "./tools/sched_ext/scx_show_state.py", line 30, in <module>
>      ops =3D prog['scx_ops']
>            ~~~~^^^^^^^^^^^
>  _drgn.ObjectNotFoundError: could not find 'scx_ops'
>
> Fixes: 48e126777386 ("sched_ext: Introduce scx_sched")
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/sched_ext/scx_show_state.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/sched_ext/scx_show_state.py b/tools/sched_ext/scx_show=
_state.py
> index 7cdcc6729ea4..aec4a4498140 100644
> --- a/tools/sched_ext/scx_show_state.py
> +++ b/tools/sched_ext/scx_show_state.py
> @@ -27,10 +27,13 @@ def read_static_key(name):
>  def state_str(state):
>      return prog['scx_enable_state_str'][state].string_().decode()
> =20
> -ops =3D prog['scx_ops']
> +root =3D prog['scx_root']
>  enable_state =3D read_atomic("scx_enable_state_var")
> =20
> -print(f'ops           : {ops.name.string_().decode()}')
> +if root:
> +    print(f'ops           : {root.ops.name.string_().decode()}')
> +else:
> +    print('ops           : ')
>  print(f'enabled       : {read_static_key("__scx_enabled")}')
>  print(f'switching_all : {read_int("scx_switching_all")}')
>  print(f'switched_all  : {read_static_key("__scx_switched_all")}')

