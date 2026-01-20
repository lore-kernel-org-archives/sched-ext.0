Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB781CAA68
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874478; cv=none; b=pscR6zzz7bmVpKQDCnpCbxlKemvQisIsawDWxGzNvLm03Xn/zQYFI3dHIULQiJbEh2aFXSZE4hwkyX1gHaA8Z6TPaUxvk70433C96eO7KDJp15oKqhH6HXQ4IqcG+fr9EMjYSSKBjFUN5vFSAPqfp9Rz7QOJCGPoOzM4JN1lNBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874478; c=relaxed/simple;
	bh=yzo2857juL/G5W4Nvl5biIIxiHg/pGUeqWEkOrOEnRk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lx6VpsgH2mLsHYCReVCDse0D0DheA30EjAT3doTIa22jzsednLp7I/BOFLyB5LkZI5+uPb+ZSI9uAdYIzrmQLmafDExUpqLsNjqvaMMYXRc4p7KngVa+re3SMmelYZBdzeD4fjYnaW8xnDAlk8OOzasa0isMN3iX+InXG+yuCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVieTbWw; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVieTbWw"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6a93d15ddso4695358eec.1
        for <sched-ext@lists.linux.dev>; Mon, 19 Jan 2026 18:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874477; x=1769479277; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yzo2857juL/G5W4Nvl5biIIxiHg/pGUeqWEkOrOEnRk=;
        b=UVieTbWws9evUMwIdwVizM0VXofBkMNfxBJGNF+407NjCCNDfBXg24IOzGV1xM6NIO
         9DewlGgJ7B2u47vC7Esg9vtkKwU7sGCuz38iJMn0xT8ipQ8jTAiAWXZQjVpiE6qHbPeS
         XcWXWwBPpSzK0BkNAe2gl5srXzzTUST1lEEyIcqAHsGqmjzHi74n1mQEb/sYk+7ZFOQO
         eHCk4EJwOgh/DQcZdPymwTIfKflKDh8Z/S2omZwWVJvlFTV23Xtf/1DoOJGqXPId0vMX
         Xh0jyJQL+Kagh5vg+oNkMsJvpoZeCZBpXyyI7FxWSLbadczHcfTuG6BldS4fyXhZRcv8
         3vPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874477; x=1769479277;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzo2857juL/G5W4Nvl5biIIxiHg/pGUeqWEkOrOEnRk=;
        b=aaJFvZwqnQHJrxAjLGiCnwoMQ0LgoqOlFRPYY239UYtohtx24x3j3ingmcazCkzVeG
         GeE3N6y+IHNgm+n0aa/Tt1hVb7oM98UOCzSwHt8+KVBOHZKJ6Xmx0cY0W9gWOoyRodGb
         BvYGbN8SSdJ0asig4/b3S7EC4ng5NW3oAUm7BeaXvrr0R3BB9KYg2lP2TjliOuFbMpHS
         ALfHlxO+2L9oNlitM9p5H/cGtaVW1uN9Hv7R/pA0b7oV23R25em8Rf0yEtoR5lnTbwPZ
         WqWwGBYSrfVq11KHvoRsKVT/dE5ag2p+ob8RP4UbgvMxH2zWPWCi2WrZL8xXE/v3j85a
         TuBA==
X-Forwarded-Encrypted: i=1; AJvYcCWjQcGyxNPNMi1DejnuKCc+XoTzm3mmScXYUYC6oNw5ExROwS61pbEp4ln6lfO6cV+ZY350y7fvptA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwMCB53H63q2VlaCB+g1YaiMfst1DTB7oIvkFWzjUZdqLqbUozq
	upJpv9ZUjO4nuGpfIUAi0Gw2HCDDw1C8KsI+8B2DpQjECmQsNIZgQOs8
X-Gm-Gg: AZuq6aKFOTa0JXIXm1YbplRfRpv+GnA92BuRTV6EcGUwFcMGJzyRlZURv1SgWWwt1m4
	arSoYPLSxChumzbu9w/tiCknxx0I9cbQB9eLY2RspjN2o96fbafUXZuMsLMFYYwN0oJ3+QLNcfO
	y26kFYuODBOWY6NMVX0JAeVkxHXsyGAv5z49zzgzaZHyvQO/RUEIBFq0LEA8Pvy51Kg2q9Giv5z
	zJkDFFLTaYhzKVtGFxI5T4v9ZQPhQ3eVzw2a30w/4nVUr8Nb8GZlxHqk1zL8M/3ESv1Ntv1eKjz
	QCy1EACILE0yM/WM45sMI+IvIMhnQRgquRKwInpI321gx8T6+7kikBG7H4BWOLU2vhOzFaw2p2f
	FG85aGJDHMWx6GkF2dFZdbIRLxbAEQ/2ZavCz0sVRM0quyemTAaCXUyrEssq0F+1zV7dqQOe4cv
	1zF7gFJjT1app03F2axZBom5Ihm+VaK1Jt51YY+VjprLmn68aTfDlkpMM/W6R700UAjA==
X-Received: by 2002:a05:7300:3b08:b0:2b0:4c33:8e41 with SMTP id 5a478bee46e88-2b6fd79a46fmr221707eec.20.1768874476451;
        Mon, 19 Jan 2026 18:01:16 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3679980sm15529952eec.31.2026.01.19.18.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 18:01:16 -0800 (PST)
Message-ID: <90135b24dcdbfcf0a5e45d49a6c6f0e18ed73986.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 12/13] bpf: Remove __prog kfunc arg
 annotation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 18:01:13 -0800
In-Reply-To: <20260116201700.864797-13-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-13-ihor.solodrai@linux.dev>
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
> Now that all the __prog suffix users in the kernel tree migrated to
> KF_IMPLICIT_ARGS, remove it from the verifier.
>=20
> See prior discussion for context [1].
>=20
> [1] https://lore.kernel.org/bpf/CAEf4BzbgPfRm9BX=3DTsZm-TsHFAHcwhPY4vTt=
=3D9OT-uhWqf8tqw@mail.gmail.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
