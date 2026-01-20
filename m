Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778761917CD
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874021; cv=none; b=PQntyOBkugalToeG9R1ZQZ4znKKjCBj3eQwJbz8n0opoPZ1W8pfKsDgOhrSo5GD93CTYp7cCh99ai0agU5AxvJyQ69KFlkUOhdKA/yEg2A8CH4s5tW0qF2JPuaRyE29OZlrKFi+IvjNm7M+KDxbAAikX2krbpGU45A3RfnCUGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874021; c=relaxed/simple;
	bh=i1WO9N6rU0xpki4AMmuxeFJwY3NuYqDajYqJEs2eZ5E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFkUaLxi69r1ttEFF0aUbHdxyc0ZEW3Y6n7Q8t0WyRjziDcI1FuzL6rzmBg5aoXm+7NH0PTYpPPjKrHKBCISKWbZg4HJZjSKa/eYgbd/2eA+pdPM9kF6RXJM4eqFds8IP6NtE5fA0jKKW7Rvvalfd2BAubbSA5bK1ayUwWqVmts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZboAA3c1; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZboAA3c1"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1233702afd3so6255061c88.0
        for <sched-ext@lists.linux.dev>; Mon, 19 Jan 2026 17:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874020; x=1769478820; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i1WO9N6rU0xpki4AMmuxeFJwY3NuYqDajYqJEs2eZ5E=;
        b=ZboAA3c1BAATLyNJwEI7wCYugjiOEvMkKI9k9kcXBNnL5G4DmaEpH5KCr94Km7i+ZS
         Z6rbeFkMMRICaW9WImdRqBot0nwKI9LoUiK+8vMWYd6ar2HX/ORyEYKoxQEfYmMVwbR0
         cRM5t5vRX5b5+Hl/KLGZOp0Q+VNHyp4t/L17DbsEy0mj9KH+vCpdtvtSrYCcCzYYkF4l
         KguGpvRb+ynAyFbOAYuawF8ONxs5oRAtXWLPm8LJ5oTZxAgfXbG8ECisYKfWe5Cl2M7z
         KAr51hUx8VJ7wMOWNw2kxM5tNEMj639rbqJYB3SfWikNS2RvZigQ+7Jh7aPMCVLfdZsB
         MeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874020; x=1769478820;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1WO9N6rU0xpki4AMmuxeFJwY3NuYqDajYqJEs2eZ5E=;
        b=MgFgtSqptZ2qIUPF3A/WvGn/LoDciHA8Ul57qAH6gOf12R4Kg1kcXJjAF6btdcjOsl
         nI2biqAQhJhVglofdPxRWryHU9fATtbcYf361TFb3eENj1V5ejG8pVEMw8qMKPGvO3n0
         EKShkrHTOXtZS5inJOt6q9Nl+gCTP/3ZFr+SCXQkNIklTx/gmYgOpf+bp6NDxnfux85B
         5xIYkui39zA9Iky+47t3k6e2Hhvv/rOsx3ViK0PFX2LU2lB1rAoEVoN/tN9QKIuFw8Pd
         8eW4XPrPHSbb/oJ20tlvtmB6dA6dJLzhQ9xEcXCBepFeul09bKphY/JhYCbGnacnMnTR
         1pjA==
X-Forwarded-Encrypted: i=1; AJvYcCWER9bPpdfxfSbzfTwJCos0+Ag/4ASFDf7eu0bjCxU90mdkYKFliWT/8qTlNvyOuTcha9T1Cs5egS8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzWPuYzKvd0zD4h88mgZJo3KIen6Bt9qngo9KpyCTF84pTmp/qU
	VBYEsneA4ARvuwocZ5UcKfh+gfmfgqKCc4YImQxnG/kFK0SVuAqJqBST
X-Gm-Gg: AZuq6aJyt7U7NLocgUQYhMXLc2fF1mzkh6+gKcebIyVFa27VoI+5ZjKGPX0C1GdVjJs
	dSUrQ8EbvxY/djVTXUKbmdY8+OtIt6rM5edfR4g+ge+lptF4wr/fy34+O8QwN8Y48TGOUVnyPan
	4ueno8JQ1BLa3F9N+3C1+UHP6puYeZfGzjpbbZ1bUL+nMoaSUx5GeguBxkhcHL3BzWYE+aYxbtI
	pr59q7fDTW63XAHTsQqD4OmvlSx/12ddC3shOFHj0gVWa6Zx6yJIx6KEZzE5jzMchrnMBDvMC2M
	XzcGEh/ceqjm9BCef16OENjT2c9THvcvXOKJhl9Q/fC3dQ+Boi1tbvjxgThvPp2XA+YZkDzK+Pf
	XAtkrs+92GaT+W94e3ygKrJnM4tC4xjj12Jh9q2ZtHGzyJ7mwuM1Z7spNUlhhxsVzfN8flbUmpV
	/eFfYo/rLQP4h0lm1gDW2N38bVSloZp+JvbBE+Yc7XDK9tFFmxIBT8lv5+C5QY/HnrFA==
X-Received: by 2002:a05:7300:7fa0:b0:2b0:52cc:fe69 with SMTP id 5a478bee46e88-2b6fd5d8080mr245088eec.5.1768874019541;
        Mon, 19 Jan 2026 17:53:39 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502d22sm15337923eec.10.2026.01.19.17.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:53:39 -0800 (PST)
Message-ID: <20f8eb981471544d6cd62d8ce35713f615f6f395.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 10/13] bpf: Migrate bpf_stream_vprintk() to
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 17:53:36 -0800
In-Reply-To: <20260116201700.864797-11-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-11-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> Implement bpf_stream_vprintk with an implicit bpf_prog_aux argument,
> and remote bpf_stream_vprintk_impl from the kernel.
>=20
> Update the selftests to use the new API with implicit argument.
>=20
> bpf_stream_vprintk macro is changed to use the new bpf_stream_vprintk
> kfunc, and the extern definition of bpf_stream_vprintk_impl is
> replaced accordingly.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
