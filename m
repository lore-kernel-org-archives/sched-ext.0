Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E8C28CF7C
	for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766097599; cv=none; b=ZVpQVre0G/JGA8spr1f/j27RxNrbY3UmClX7CphwWL4mVh2VQYk6ZE1aME2h4+MbORcpsTG1fgObhoPkb9qmoHfIuTTMtCLMsyxRCbAzdj1JlkDB445i0ngyW9/PphJ9fZ6KhYfQjMmn0xvrthdjV9DMhpUG1NhZqTpZWUIPhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766097599; c=relaxed/simple;
	bh=eamKHa6W7ULY0ixSx/sof431csrKXdlpYvmmnDnJOFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJA/+38w1ihivS9NvIn35mHLYAqk+03rLe346KF1cCjP2gCiemcNwbMiMvYvIXUTDaL/dlo5Lvjy1+R0JDnU64WqzJ1oM9Hw9UUZQmC94PG+HaHhbZG5bJrd2RiFGYrCAGL2jAvvCba8FPXQy7B6F0pHl0terxBkS8/TbcOzbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCxn7fW1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCxn7fW1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0b4320665so17163775ad.1
        for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 14:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766097597; x=1766702397; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eamKHa6W7ULY0ixSx/sof431csrKXdlpYvmmnDnJOFA=;
        b=OCxn7fW17dRX+f1gtVGyMti8mCelcFRVkRmserEhfU/PkAKW1f4eVKdbJx+bGOAKCu
         gqlCR3iqSqnu6FBcMOe3/+dd4yamsKEIbs3RK4c2kQ+DQIUkJl+9BXul3Rr/U+J36v8z
         Wzqj8gr9EWgUHcBPwLaqxiIIbNpA0VQK2u49uF90q4JzsEAQ4afv2cyx+zyJg5SGrqKt
         MUkSE6w1KNBKWEg8QJDhsk4pkrquxAnF43mj8qwTDmKQRl0JczFUxJ2Uh88vMjyPxP5b
         W5wsrFYoZiJOQ80GHPTSF5iDBsYgUFqCKyT/ToyVkpgpK+tmsxS7eIH0VozQCl7O8ofM
         0uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766097597; x=1766702397;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eamKHa6W7ULY0ixSx/sof431csrKXdlpYvmmnDnJOFA=;
        b=BfgnqSpDuLvcysY1SMXOQpBj4ZIcph1qYQpxZdlyXsmm6EGhEgQEkvbOuWNex+cJ9J
         7dE7MXTHzxc4Hth1oGb6wl+dEdn9SWF8EIqba5WTwZ8Y0j7Uy/t6qTxqcM9N4QCnNAUZ
         eBfNdvVnRAzW7q173elGlSSjgENM+Kz5Ctv4fxTw3aV6BUWPDe6KNFKG3iQ+QeK9SBM2
         xoAL4oioSrjqdi3vVdQvNCEQ7X+STL/PH+5WTJMCGa3zOLmKQbU1cGOUSKe/gzMd8rrd
         fWvX8at6WcopXBzG6rKqGco1MZ5qnHZ12GveXT+McCyUvBM3GJ05R9udlgFkfIKvOQJE
         rjZw==
X-Forwarded-Encrypted: i=1; AJvYcCUcxIs/DXuEbQl+MB6P6o+iHc9e82BwXaqFyqODHqr/WsPLsJOiRktJRkxVpnLE7nQx7zNnxfd7z8E=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzoc8+i1xfpIDNnmVnoldNPAJrJeKRvfKtqd++w4EvWkLKSV7vI
	kjhANk+Ng8aeUlUwMQrPAKuA+aNZnJE9sUmeK3wo1Gps3Zl+7+4mVC4+
X-Gm-Gg: AY/fxX48LgJUvdmZSPi8i0ZFLGnEuGG76lpEKZNtj73l8DjE66yG2bwylrqud4nEzux
	RM6d/ktj8foyjg1H5ZbYEGkcIUB6p880lEuy6CT7fyQLcDO+uZLNgUK5TXrTfhSwSv8wdRUWr1b
	yLMHnhAtR4kxqFxpTRaURzGglD+dMYF3A5/iEMTStPkb9lTV6op/qYoTuXXeJkri/O4o+/Sghpd
	R8Dju9voaMBXX6G/zFaQqc6q82dFEnh0WwOeKzqLbNxGUW6mAP0stw7tiaHxx9wBfSaCqfvbndt
	5QwKCFhnSieUDPQXI/UCT1h9M2slo+E3jkDVRqibr+xLd+Ck15YybN8gfNZqoQxe3YCtW3ZTL9H
	NoPYCcf+KxMg/ZZAdVOjN4LX55irXpSqBQbSwr8QAvBHhpSLn19yA339dFnE+viSSnMrVBioZ0n
	t8AbiOs3m2dxNJgYtPyjQcxt1mIs3Fo+R8OMXr
X-Google-Smtp-Source: AGHT+IEVSlp9LXlzmaGmg8SZZsLd9mJhWKS6Iylg31EbQc75zWEKIMS5zueMBmRpuYcgZRvP0hKo6w==
X-Received: by 2002:a05:7022:2586:b0:119:e56c:18a7 with SMTP id a92af1059eb24-121722b4e90mr878908c88.15.1766097597216;
        Thu, 18 Dec 2025 14:39:57 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm1480954c88.10.2025.12.18.14.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:39:56 -0800 (PST)
Message-ID: <62a74bb81d7e791cffe4aa52bf3e18bc854f3edc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 8/8] resolve_btfids: Change in-place update
 with raw binary output
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ihor Solodrai
	 <ihor.solodrai@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrea Righi <arighi@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Andrii Nakryiko	 <andrii@kernel.org>, Bill
 Wendling <morbo@google.com>, Changwoo Min	 <changwoo@igalia.com>, Daniel
 Borkmann <daniel@iogearbox.net>, David Vernet	 <void@manifault.com>,
 Donglin Peng <dolinux.peng@gmail.com>, Hao Luo	 <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend	 <john.fastabend@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Justin Stitt	 <justinstitt@google.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers	
 <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nsc@kernel.org>, Shuah
 Khan	 <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev	
 <sdf@fomichev.me>, Tejun Heo <tj@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev
Date: Thu, 18 Dec 2025 14:39:54 -0800
In-Reply-To: <CAEf4BzZA4czi1KEOrW9tn8v18LZN4FAqzrHyB_78VatEZhb+Fw@mail.gmail.com>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
	 <20251218003314.260269-9-ihor.solodrai@linux.dev>
	 <914f4a97-f053-4979-b63a-9b7a7f72369a@linux.dev>
	 <CAEf4BzZA4czi1KEOrW9tn8v18LZN4FAqzrHyB_78VatEZhb+Fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2025-12-18 at 13:15 -0800, Andrii Nakryiko wrote:

[...]

> It all looks good to me, so don't wait for any more feedback from my
> side. If Eduard doesn't find anything in patch #8, please send new
> revision, thanks!

Lgtm, let's wrap this up.

[...]
