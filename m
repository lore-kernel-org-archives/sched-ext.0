Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48B231C91
	for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096025; cv=none; b=OAT1jTIDIPe5eLNqMD0ndGXJ8B3JddY84QuS9/AEPUuIdmQ9lUFjOrNk7EHfL9bjFS3jc1N7IHaYHTMyf2ISEArfhYQZYYHhYm2COht6nKkXp9Snvg6vGvZ6kAY5Da9Rm/Hf8RAUnZ0onsIdRQPnuZjDSg99juhnpY/yj6n0nCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096025; c=relaxed/simple;
	bh=W37rsOJmiEerHAWSvHZR4k9Y55pTRmIbZz9LXO2kYKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp3cahY7ypgbTsSeD+fSRYQmdrPm0rtM2p//DJs22J2Z7m1fS83HRJd6rT4Avxiv5Z7TFx2MX86SGkTWIRBVMd1kTmn9ao6Es9FpKen2JSZMULVwmJjugaZ2vv9NM2okDvYJS5ZLqV0cTqsnm5awCbHqepeoj8w7saBvYMSr420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuOPsQrI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuOPsQrI"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab39b111b9so21268405ad.1
        for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776096024; x=1776700824; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTJa7CwUPwlW+IKQHRWNNTjmjQ0ufdgLKObUXurvS7g=;
        b=FuOPsQrIkJX1Zrc3iDQixAVNmwlOQ2UicVk08ZUNc/u4ou+MOjmfMCZ8K61LPacTm4
         E3bJAjLpThogwvTHvLNtvQcqo270XUUNILL6IOCwkhbakW3diF5d7OtR+z33jNBof6/F
         kTu0vMgk5yq/m1xHGCZ1MycMlgqi+6zAPHkDSyyvx6bQkED3TY7CYsmeqh9NgNOfg4Tc
         5+3lcU2wNT3m7b1bXeBJIEbI3lnUYPxC8A1AjRjfExcx9NKuH8+FvDeUYLtpEkH7uia7
         rF7bAfpT0GgyARjKAX4Xp+EOiN0K+ugu+4SkXKI/mJoik9Aaf5dZAVTlRZ2290gitwyx
         z8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776096024; x=1776700824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTJa7CwUPwlW+IKQHRWNNTjmjQ0ufdgLKObUXurvS7g=;
        b=lhUTNL5sKFrdL+mT3FDW5/R0F/QQygK1VdCr+5wKPotKsq8ZZUwREDwuYWBDyoeFhQ
         g3KmaYsJJy6t9A5sfUXNunAC2LrKR3uwvpypSKxbUcDLaXOwPjyyylIX1iNkb3Zo3Aq4
         qxZfP9QvHATxlZiseRMw3HguMvkWZYka2FuLnm68FU6ay4c/EaPFZlx8ZEX+fv5ty4jB
         vMq7tSZ7bjmzXSABdo2q2G2CiRvJzIjbPTQlijkm5oHgZdug3jtUIWE/BTkwNjS4XCYx
         iFl85A8o5u/XGqC13IQVFx7IoTeyB9yfpiS22bLK4njz4VtaG/LC68S0vmNfEYUILybX
         Uk+w==
X-Forwarded-Encrypted: i=1; AFNElJ87459fSd7b8U9PXe3aXjGTAAcpXiJkBswc/3eIL8ACGBlS329oB8d9g1vJAPxBo7XsX1qHMMDLoy0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxcNVPAnsiOlAyzkPy/012AA8v9d34olEhv6PyIZ3NCtqX0uCkJ
	aYtFKWrCDvfNuQdPMD3l7pnP1mLZpp3qaumY3gQ48lMF07cz7QNtDOFx
X-Gm-Gg: AeBDiesY4f8aIWs14a5wDV5vf4IuSh4bU2WXpPPHbqu40YFdTH3TSn4o95EZACIIU8j
	OE4cnBRHSh/W4ufX8/7/qSDdHwIslYROFi1bnShvWEZn1kRBRCumXgjM7gUQamVZbuGVCIx5lbo
	bBqTyK8gS05SPQ/XWxqmZ9cPFJgwOsfMPUloK+8tGvbbyBmSHY4BZFJnbG+jZIDIU+BfSzC7QSR
	Jk14hRzPbyiwKLYhET9tsOrNRL+R+2Xo32l6ODXn/q+sdJOhBWNKs1axryhyBx0KGSmQcaZbrR8
	fgSBc1A4AdnACDbkCPEQ/C/iEFp/3xUjREafM7ACmlDb26bNGmhtBhF930dZ9NX9BDP3xWxuNiC
	YA2apJMzC1dMNNuQ/8WSNxCL5T/Mhq9yafxEWnyYVF0Yds4MlnyMEoZp8h+odLdarUA783Him1G
	U8716eslQOEe4Gpb3UYmMqSw2vpOU=
X-Received: by 2002:a17:903:a46:b0:2b2:5491:e32f with SMTP id d9443c01a7336-2b2d596b6e7mr91394585ad.16.1776096019224;
        Mon, 13 Apr 2026 09:00:19 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:c704:5352:540b:7ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dabca4sm120150805ad.15.2026.04.13.09.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:00:18 -0700 (PDT)
Date: Tue, 14 Apr 2026 00:00:12 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Samir M <samir@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, sched-ext@lists.linux.dev
Subject: Re: [mainline]selftests/sched_ext: select_cpu_dfl_nodispatch test is
 failing.
Message-ID: <r42kctxqs4bqc3qggtn4rpgpbiqvb2aza33chr6k44e4zhhsuj@456kplotlgiv>
References: <6424d036-7fab-48cb-b0df-81cd93dab781@linux.ibm.com>
 <brxswoenmxred6laqrqxpxhfn4cdmzinnbm6wjztej6noexqld@t6budyxgehuq>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <brxswoenmxred6laqrqxpxhfn4cdmzinnbm6wjztej6noexqld@t6budyxgehuq>

On Mon, Apr 13, 2026 at 11:55:27PM +0800, Cheng-Yang Chou wrote:
> 
> CC sched_ext mailing list,
> 
> I suspect this is an arch-specific bug (and perhaps not a sched_ext's bug).
> I've verified that on 7.0.0-rc7, all sched_ext selftests pass on x86_64.
> FYI, they also pass on kernels 6.14 and 6.18 on x86_64.
       ^^^^
       I meant select_cpu_dfl_nodispatch specifically. Sorry for the confusion.

-- 
Thanks,
Cheng-Yang
