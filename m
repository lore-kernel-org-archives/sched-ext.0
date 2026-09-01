Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6880A367287
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229214; cv=none; b=NpRVWHHOOjb1wzGr94xepi1yKbB4rNJIxWNTh/5bXltVjmWXq6PDkHRKMZ9A0AWc1XgUp07tHOtDeJOFr4kYrSzLCN8OzOTWgQytBupV4R7hGk0oXNKGb1gwIdWRMy3JcrJg/DNWEE3SRIV4CL3Obhflq9h80qt4WBNmPIi5/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229214; c=relaxed/simple;
	bh=pReCZ/lZVigpmnECFh75mQTJm3paN7ZW20fAMM0zJUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ld0k6WN6IR9RxQ4TDhcHfe7krjOTOVgxQP55SSYha2KTJlNE+nJqDBaUFMcMJ70RCZ3xLl8TKIkckb3PG1JaKJSRvLT4sBtDba7IublixtHA5RP/TVBx15H6K2MbQdJ89Nu/RJ+uSRF1HYHbLa160fvH417JuwpeDlamdwiHPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR4uApsn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR4uApsn"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-853e2610bb4so406103b3a.0
        for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 19:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788229211; x=1788834011; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7V9z4lGg2Zq3oLqNbA6E6uUJgmE6UGQOAlFEXJea6E=;
        b=UR4uApsnl89hjGoLmzqgF0X9NuoG7g7JkpKd+qhDvEJayVmTuZ7K1T0rln4HFC8qlb
         eA5ZFbPCH2xvImlGwWn7MeHZeMrCbOfaLqb4mlpm5O+n7kHCJvEmMXqAhXwucdoNBvCm
         SCPDTTdhQgKOERAleisLIU1QvBitq5HCx9zivQAa3Kg1hMnm8lcnzg61ZFHqllZKOkG9
         JTnjpkdNZR55gSwoRqS7pJBdy/H+Dz6b/sndNzO/YWty3mhue0UWvlur7rES82Yj29Cj
         iEFwu8RpINt/oSVoXDfdc9r61KhLNlrmckfdLu8CKJVcdb7dQs3NgD9rB5vDfRpj4fT+
         /q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788229211; x=1788834011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o7V9z4lGg2Zq3oLqNbA6E6uUJgmE6UGQOAlFEXJea6E=;
        b=RrimVSd1t/6jtqUAOPVnBQxFtuaGOXQHALz7SVAU6bGG4lj4bHuUlz4fTA78mz6tf6
         2N1+wIpI8BGYwVWpqV+XqIXSuhQ+ClArz0Joo+l77RPPREIB802dOi/zzSATavtrY8Yz
         W/9FLSbiUGpqOfUU0vhIh8M+X3lC9URKb1ZXc5j+Swt5WkLfsBrucFZAp+xCgdbTau26
         nSvXufaWjYiRSaLTfPFzi4aH8CJhHXactj5lenR1tSpKjyowFVaS7FH9pmSSnSSRq69p
         n98gozkByFFwji/CliKe12VRfU4UFJdYEf7x27XwT+B2TSeWljwYBWu9GfqMXVNIhMSK
         luqQ==
X-Forwarded-Encrypted: i=1; AHgh+RomQbDAnco5a1mR2rHW8UP6Pl7ouHeUjcXiNdquG1UIw3bl/WXdIUGTNM/MIzERHJkJIjlCybHZY1U=@lists.linux.dev
X-Gm-Message-State: AFuF++lRX+ph3VsZyL+Lm/HAz2ibStLwpssWKW5esG87sdujMrw5T4rv
	PdZWTi/dde6iWWVEdMCvX8BXAHJLn3zf8oYmx0M/9nOIf7JoTF9wzyTD
X-Gm-Gg: AR+sD11vxRP4OMTIbt7W5yW0ZaC42jt+eM5lmp7fg0FLCXF5Wrb55GqPdGJ3GfUsRtZ
	1s+gKZ0wNdB5O1xb2IeWhnmSeORXqsBC8cReUlm0ez4jggOGWmY8L9+I2LYsqeosSQ8HMsq8FY6
	6zE3V4RBGf/+5/9mu7RE0FWNzlQ4n6tdag5nL6Z3TSbLUbAJzCQrqbHQHZjplhD6sEC62V/6wFV
	2r3ZGDWC8twGcrWp/9EhloLvLN04kdelRl8NoQIe2xuw96EdjB9i96+9rw8Lnt707jg6vv8tBWu
	NFicBj2OEY9gxRKMcq8v8kZ28YZlnnoftkihhc9cjvI7kQB5TaKU3GvA4RKshRF6WWfK74/QjqJ
	niIxXTxxegVRCDy9TLZEQi3fJHv0UDS2eEFJg+Su71kzsD1T1syljfZGAZrenMB64PYEJouYE8s
	YcPpspHv+ONiuWFOsComC85nPIW0T2cENOH5HgT6qXKzgwSgfoUk6LhmN1yT7RrWBcCIdBSRro
X-Received: by 2002:a05:6a21:71ca:b0:3d3:aed2:6f20 with SMTP id adf61e73a8af0-3d8192ab0cfmr1860014637.20.1788229210603;
        Mon, 31 Aug 2026 19:20:10 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f32f698bsm5063022a12.6.2026.08.31.19.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 19:20:10 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: fangqiurong@kylinos.cn
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@kernel.org,
	changwoo@kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v2] sched_ext: Skip per-CPU data allocation for built-in DSQs
Date: Tue,  1 Sep 2026 10:20:04 +0800
Message-ID: <20260901022004.1824584-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901013258.1822890-1-fangqiurong@kylinos.cn>
References: <20260901013258.1822890-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The v2 note says the waste is described as quadratic, but the changelog=0D
still gives it per DSQ:=0D
=0D
> Every DSQ still allocates nr_cpu_ids * sizeof(struct scx_dsq_pcpu)=0D
> bytes of per-CPU memory for it.=0D
=0D
Four of the five built-in ids come one per CPU: SCX_DSQ_BYPASS in the=0D
for_each_possible_cpu() at ext.c:7173, SCX_DSQ_LOCAL and SCX_DSQ_REJECT in=
=0D
the one at 8679, SCX_DSQ_RESCUE per rq in scx_rescue_init().  Only=0D
SCX_DSQ_GLOBAL is per node.  So the total is nr_cpu_ids squared, and a=0D
reader of the changelog as it stands will work out a factor of nr_cpu_ids.=
=0D
Worth spelling out, since that is where the saving is.=0D
=0D
The code is right.  scx_init_dsq() memsets the whole dsq first=0D
(ext.c:5046) and sets lock, list, id and sched before the new early=0D
return, so nothing a built-in id needs is skipped, and exit_dsq()'s=0D
->pcpu_user test is the load-bearing kind: 7101, 5367 and 7334 all call it=
=0D
with built-in DSQs.  The only reader of the per-CPU data, ext.c:1130, was=0D
already behind the !(dsq->id & SCX_DSQ_FLAG_BUILTIN) test above it.=0D
=0D
Reviewed-by: Zhan Xusheng <zhanxusheng@xiaomi.com>=0D
=0D
Thanks,=0D
Zhan Xusheng=0D
