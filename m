Received: from mail-qv2-f10.google.com (mail-qv2-f10.google.com [74.125.230.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175A568FB9
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967547; cv=pass; b=M0IiRklMs9KspSMdfU8Sbp5rVVk36wjlmOx4OIBx9btcnzalsU+kgDGbUOmvcn2ssVuiy9FJcLpMC+gsuhuT0JR3gPwAHhwHNRvDzd3HfvpMrFyYGdtWD8T2I+fO+zxDGXd97jeJezyJsxVF4TnmiDWF7M29w2zNSLXai26b5QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967547; c=relaxed/simple;
	bh=0/Jm5DAY3AamN+rYMx+HuqizbAknGGFn26W9uqNpDbc=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2ePGtJWCn6nuK3LaG6yU7Tg3xDfFGSGeKUw8GkYzWqOy7AV4BGeIhcst9aveGx1H8ynrwyXkWxZMyhWegROGhzciHaX8nqf06bCXKBMClB5ASZt74BHB7RJbP1ckYVREGwGhFh8ohEyBPA2hhOcW1jaeZf3ehcKX8oCE2YhIi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+PAHhkC; arc=pass smtp.client-ip=74.125.230.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+PAHhkC"
Received: by mail-qv2-f10.google.com with SMTP id 6a1803df08f44-90e886b47d1so36511886d6.0
        for <sched-ext@lists.linux.dev>; Wed, 09 Sep 2026 08:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788967545; cv=none;
        d=google.com; s=arc-20260327;
        b=H3UD2hb+JL85OoX864m/8oqjJgeek15rDcY3Y2vwHhKtBKAVa3evkWLNJR4E927+t4
         aY36Am55AT72pv20foSJqbn06+BvTQTKKSSXLq1AZHjLHO7nP6Y6Q4q8k6sO4zu8eQdK
         UwSe9Hsd9bWIlNCfKjN2L2Pldhoq8q0laAIO4xfzgid715c5bCj74Uvzc7ZFKN/fdRiU
         PhobFF7t4+xxLHvcESH7F+Gm1eN3NbqMoFHpfV2yyEuB3P3gWjl0mFOi2ssW6TGCkDJM
         qO9jqkPFz6LvvZmUBU1uyWtL5aMPjX1agL5ZwMJRE/bf/5euqz46NPPHxvPFVwAOPW+8
         upUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=0/Jm5DAY3AamN+rYMx+HuqizbAknGGFn26W9uqNpDbc=;
        fh=vlDYfOFg/2eQcyq7ZBqDSxGsQTUxsu7fl4wSDxPyugk=;
        b=ihTYdZLk+HhOUoHolE0Bm0dx3QIHwGMD+5pgAeN67Fk214KGv8KvDnzFis84WBe13+
         ZS1NCvynwWHNgtAWa/JT+1wRlhBWydlODIHTbKj7DcDaxXlrwL+UtEISs05I+9S7R7mG
         1jrnMbNyHZz+kaZ+6ZfdRe0AbzvQ7c6SyhiWa3oOcLjIlMOuIq0uE0ZIsRRhDqCv+TTY
         r447ZLL30gHWpT5YYBp+7StSLNFOtujxBdjyGTNS8MdH9aPlSuU2vF7Ei7v5Nbc2cRVw
         W7iEKKJ60KyoMLskbXxvMH+gX4A7iOHsgHVeAwsWLBsm4KvoSqRCLmxExeleNZ2gEDZW
         rGZA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788967545; x=1789572345; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/Jm5DAY3AamN+rYMx+HuqizbAknGGFn26W9uqNpDbc=;
        b=n+PAHhkCOTOkkZeJcaWSDPHrd4EtgJAx0O3T9tQpfpHsZgfNC1L3HnfgbrUkc8dYNr
         TeyrftrcFNvEgPfnF6D33Sc7eos9ZUoeTW1VzAj3ySBguv1E3AyJasBjjnBYUUp1vGPk
         kKk8YFd6VkJJZKRqIx8R/iyZrCgJhW5nTqHgdUVRNZYGrbPlFG6taSsOLJIaVa/hlIXR
         5wwPohJItvS0wmuhln6Ive38tRj7Qsdy+f/xn5TikSTUc2Jj5gVvaATkhoT23srdVQeh
         rGH/vxw0yMfL5onhximkjyj8zia67/9Z56nUmeCL2l35AzWA7nVnrWDCyhaM1sBx1cgl
         Cfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967545; x=1789572345;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0/Jm5DAY3AamN+rYMx+HuqizbAknGGFn26W9uqNpDbc=;
        b=g/dTj/e/W1TE1ap3j7iSVj+Y8o8NNOaVPkLK+ifchbiRVtpPEqGqmJi1USBZnMf7i2
         sroom+xOYHEzCHZrUeckVn6GGflvORHizEIRq1hIU2zUchZQ1FDIgOCFvMzfJZtwIfrw
         TgRbq0puoCOqGAJ9Mo6RXVGZ+JZg9XLNQkgSe1VKntGSVFDkovJRyoEyI26ZWBBng4GX
         17b4q5KhCnyxcwlAS/p/p859sgSwLhm8YpKEZMu8DiyRjNSBnIB4fCTfBKMSfmZhd7Zg
         6aiK2tL5u1C4afYtlBnUIHxw8ub4XFUGwygev//FilMWWFIImiDgz3KEWpJKkvWLlrAV
         0FDQ==
X-Forwarded-Encrypted: i=1; AKwUvByuReOrI4WOTiSOOVLHfO8U4ApPVY3dDGY5OpTcXiZFSbXVGGGJ+5wKLhfC9lvvpQJ6NfPYncoG7NQ=@lists.linux.dev
X-Gm-Message-State: AFuF++nMi1tB004E1Yc0RkJ7K8P8NpP9zTnxxh3rYynxDlIT2bHIXDYs
	RnELnBKTTMLy+WsuQzNPl1r4As0ctaZEmuURrLh3Jyevti72AmQSlzbEFEDxUZMqQTZzDIHhNaC
	vb0QubsRPfbbxTGNenWEewlWkj1HIwCl6w9BPPhU=
X-Gm-Gg: AYBFou3flAXQ2w6QKLR89ShglX8hvECEJkJzx16IcRQ9FmqhuzLqik9vI+V8cTCei+l
	vSzsEzujOG9HEJdMbdcV+LtJyA+m0WVBbhQF9jjFlbZAcnK5TkCIuCk0dQpVVp0nYIHl4+1TLan
	ihNY4t7ODPCfDxsvCzQOXyof3VX5e/tSxnVcG1Kc7fYCrHMRNaIdRwIzDq9m6bYu+tD2fsSIspt
	rOfaq8R68UqQFYEv1tmuIz2xDYmUpZBb6SZndUbFOS04Tk17hUMsmK1/nriANso4/hK8xQHwImY
	RrRNJacaefi0X5NoCBK04WtmB8OfqHAzfJkW0aY5twTTGnrwx6/HBA==
X-Received: by 2002:a05:6214:3f83:b0:910:49d1:3a7d with SMTP id
 6a1803df08f44-9106b371d12mr101320656d6.3.1788967544656; Wed, 09 Sep 2026
 08:25:44 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 08:25:43 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 08:25:43 -0700
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Tianyi Chen <diannaaav@gmail.com>
In-Reply-To: <CACGbirQ-xfWymbY9Z440sjbUseLRuaPFT17mBAwddeN7wqVi-w@mail.gmail.com>
References: <CACGbirQ-xfWymbY9Z440sjbUseLRuaPFT17mBAwddeN7wqVi-w@mail.gmail.com>
Date: Wed, 9 Sep 2026 08:25:43 -0700
X-Gm-Features: AcwNN1XbctJykLIajwUrOJ8N0MtuRTsipdzh4r2QkiO3ZZ9AV0_gzwQwPujw2hI
Message-ID: <CACGbirTmyi0LHZEr4xOwg_WgFALarFVPMm7JhHBbXwG10PF3KQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] selftests/sched_ext: Validate select_cpu_and
 mask constraints
To: Tejun Heo <tj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tianyi Chen <diannaaav@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

Please disregard the previous Gmail resend in this thread. While
investigating the same delivery path for an MM series, I confirmed that
outbound delivery wraps long lines and damages patch whitespace.

I have resent the unchanged v2 as a text/plain attachment:
https://lore.kernel.org/r/CACGbirTEtYnxiZW0EnOCHbZt66=t-A_Nppp0ChRfM9G2ZD5+aQ@mail.gmail.com

The externally received attachment preserves the patch and applies
through b4 and git am to the prepared tree.

Sorry for the extra resend.

Thanks,
Tianyi
