Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4A2DF128
	for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121969; cv=none; b=M6bG4EZRxRi6pYQ/t8FZtUccZM0Sap+S1EAPjZmJyTAROcvQH7zvu9l39vMJj+q9pUHA7kVRWSitXkbtkXik02SnBy/klNqBn/A6S3fo1gkhRyUQUfQEd3j7PEF9F74OQymW+9+RyxZ8GmheG0sKTicXwvC6QN85K6EJwVMlwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121969; c=relaxed/simple;
	bh=zqdxRvpID1mgu6WpA6vjSxUeMH89ZzlE9/uL4SHLTeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tipFwhKYCZ810+l0W1cNTyJxSVGRyiakxJ2eXYSB2bXQH/QaedaepHoa7UF3HOZd3lmpMGbLLnkCbQGkXU/LB8ZRNEViow/G6hqMZhvhutK5ALeIOxddD5YcIwgk1sQLg5vnc1zbGHGzMP+m1U+43JBDnuofXfWx1kA652WzBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e38Hn7FU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e38Hn7FU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b062069f80so11459555ad.0
        for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774121967; x=1774726767; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUB/OQXVA/wV4NfVTK5aeqhmJd3PPkhrERkqiA3UJnw=;
        b=e38Hn7FUATPGxNS3Fput7BgjcOrOZgFM/gZa9zaikBFIeDYpAHldCHoMGyJcN8wsMv
         uji6f/fSg1A5/Y2TrId29Y6CmgMd2KyNCxY4/PBh3+3CIlKVpAP5csH04dtYx4YTXtSv
         rAegeLkI7F+7BqYaiQth4OiXWqCMxRZsIuvhHdYWyK+ALH7LFHAmlyC8jCv9Rne8b7r8
         Xj6VtuG/Wzlf95bKcELgdm6FO2gNKp0EOmtsets4KPCSNNlUSbQA74soIEyYwT3oUL3h
         sd922dAmui14cdkmwt+gXwBENNEapMXJFPKen00F6oESXTflenJpeGHpGXfniJ3Q58RM
         mLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774121967; x=1774726767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUB/OQXVA/wV4NfVTK5aeqhmJd3PPkhrERkqiA3UJnw=;
        b=Rb9CEwFD1g5ppsN2QJ0bEBydY1Ul4NPh0VNyAMLA0wM5oVZ4mY94MwKgspQ/XVmT4A
         NHEuRckWhOH6mHnJbTWLgEfSBp31A9oxxBOBd6uYIyPne3S+t2m4tBibBqJOh4jczoih
         4U1KisqKx3ja6J5RfQlTnuXPcT0cPS2vO1DNnbefv2CDOto6qz9VkafltTHdpiPzcc/Q
         qhbVJZgVgIJ0Xwx2I0SDB607m1PXPLOKUZhaaX28KZCORL0Ih0mCWieuFsKUNPTgR21P
         YeO8Ywd2m5t1GXS9heD8cLJG7CgZcvJ+d5fw1+aQDFm3SUbQVj+8b69qc9Xp8xSAUB4b
         4hDg==
X-Gm-Message-State: AOJu0YzhfFiqCqhlQ+gyTuveegqvDDJgSqzxjweTZNPkpRJNUvweGR6m
	VyxaO6uoyWduVxlSENiqxvZGQzwz5vF5GCeZMJ6gDoxcW0wIzVlknkWx
X-Gm-Gg: ATEYQzxWGLUAk7eJeBFeaLuEC4zR2DU17qClgAduf1XeBWKpJNsP1eMfNCbIeadLK3A
	mJ2v21eDhurM7ZVWwo96ny8Fjrn5QAWr79tv2ZXWkmcC3bfYK9KSDfxs5mxzbFG5SG3mQXKitT4
	m28Bv5d6Xy3fPnuFtqj6vPuYlPDoNeguQTF/MEeJEPmbswDwwRCS2MKqF+k+GzTCDuWCyMEFxEW
	4hvIcuDuYcdcYv7i8w+1CP20mA7ts6IJA2aTPvLCllRrCYyquMhwnifOrON5TcaVkoKqpDJKq0O
	l27izmZuYDy8Dk1TTY83J+4Y9H41CrjG7ZLnMX/5UYQ70sTwxfozVrd8jc3Jt6YT3hPlSDLty9n
	klDOY6zmo8tWMVOt29AHzeDb13q6b25TwmFqGY9mdVk4yDcuQ6jmFXtNvxGv0I+NTTqyDyaC/Br
	KAkeqmWzGbgLUINd220DQSjEkmJrO/Cb0bvDfolRA=
X-Received: by 2002:a17:902:d2c5:b0:2ae:ba5f:3ac3 with SMTP id d9443c01a7336-2b0826ffe72mr67300535ad.2.1774121967202;
        Sat, 21 Mar 2026 12:39:27 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:e49f:fa98:a4ba:8111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c56bsm83552845ad.57.2026.03.21.12.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 12:39:26 -0700 (PDT)
Date: Sun, 22 Mar 2026 03:39:21 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix inconsistent NUMA node lookup in
 scx_select_cpu_dfl()
Message-ID: <x7tnnq5w4erborennieyyfi33r5v36an5sjh2sjnatsfqsjgon@leje6vtro67u>
References: <20260321105503.869337-1-yphbchou0911@gmail.com>
 <c30307f7e69ca3abd6223cf7a9f64351@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c30307f7e69ca3abd6223cf7a9f64351@kernel.org>

Hi Tejun, Andrea,

On Sat, Mar 21, 2026 at 08:42:13AM -1000, Tejun Heo wrote:
> Hello,
> 
> Applied to sched_ext/for-7.0-fixes with the following additions:
> 
>   Cc: stable@vger.kernel.org # v6.15+
>   Reviewed-by: Andrea Righi <arighi@nvidia.com>
> 
> Thanks.
> 
> --
> tejun

Thanks for reviewing and applying the patch!

Regarding Andrea's feedback on the commit message, thanks for pointinig
out the short-circuiting behavior. Since the patch is already applied to
sched_ext/for-7.0-fixes, how would you prefer to handle the commit message
update?

I have sent a v2 patch in reply to the v1 thread with the corrected
description. Please feel free to drop the current one and apply v2.

Alternatively, if it is easier, the commit message can be amended
directly in your tree.

Sorry for the mix-up.

-- 
Thanks,
Cheng-Yang
