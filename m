Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643376;
	b=jQjMTe2H136yun+0oA0mKBRqmV4bm7Zzmkf/K7v8WaJ/v7DHFF36/zh01xwSkBwUKvab
	 +8a7TTk0MwdfGkhfvuWYfR5oQDR6stczgSlshNsE484AIDJlsq4hPaScMWOAsrANvO5Ra
	 Xj3/Nx3CCt8JxEOce/gXOJ16WK4yFabVaqH/YC9idmx+ZxSssR1BZrq5OIXaAImATeO9B
	 CB/4ldNX1ZjuFry8k7xyYNXEm7Hlrc+AwkvuOWFx9rT3hwhrH8YxUYAJ8ef+p7o89+gB1
	 wy/rFKHjdSfKOSwnab5BqS9GgjEUcMAO/7xHtFmIajDnNlDkGCuIE1OMQh51pHTrJxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Reply-To:
	 Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:
	 Content-Type;
	bh=/HSK8bCv0QmKIxt+V6gWv55kxdgB1pVhBKVyk2Y6wxo=;
	b=joZONOzLQRzLwfBnL1OROt7jS2R4pNoiehUjfgAZ8hERH6FiJ1bFbmLxlkQwF9NVYbqr
	 Dk1Z/4PKMbQPrCSChFYXlva+VcWYrw5eAOsJjf1KLmjOqbOtajM4ddquw1OEIgs67VZKh
	 Q13SDZwml/kzklP7VC44iZ3yWAnAavJmiBehSO59OBdA6kMTdEoj/s1P7qUjt0KHfEvTT
	 wisZa4tbuVudWHoDlV01P27mGiOKe30ZAKhRQJA7cFu4IzId4tb6oVtJH/RozuSc8jGr5
	 7EORi/xV6+gyFqYGyDYbIQddYVFAqf52sUXwIW2BRui0C0W0c+kD81MWbyz2v5OXX3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtoradnan.com;
	spf=pass smtp.mailfrom=realtoradnan.com;
	dkim=pass header.d=realtoradnan.com header.i=@realtoradnan.com header.a=rsa-sha256 header.s=google header.b=PALrJ5E5;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F62606A329
	for <sched-ext@lists.linux.dev>; Mon,  2 Nov 2026 18:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F62606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=realtoradnan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtoradnan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtoradnan.com header.i=@realtoradnan.com header.a=rsa-sha256 header.s=google header.b=PALrJ5E5
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91791ec1b83so25295526d6.1
        for <sched-ext@lists.linux.dev>; Mon, 02 Nov 2026 10:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtoradnan.com; s=google; t=1793643375; x=1794248175; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/HSK8bCv0QmKIxt+V6gWv55kxdgB1pVhBKVyk2Y6wxo=;
        b=PALrJ5E5j8q8VfvLFEUFPL+LyCMe1uXyi4pSnfqZTcSHy5R6G8q8gAOUeLzhjJBbnd
         s/IvnmHLnXG8SginhffTgHs72vRWuj36d9jxCiRvFBKmdscseGtdCQwbNFOCoybfN2Gj
         5gPMwJ+iYl2yFuQ3YsMtZMwyMehjACo1s1NEINgoM3JZqgoY/nGbIXpIj1wxjGFOdFfo
         5vYZSjzlGXqHSQ2T4uml5ik0IBpalxxJC0g6IQeWbIybXgggYPdSmfi/p9Vxi+UW6VtR
         zbuEHXRW/uQJEIAfDpnPuVk8nasJdYq8VOf7Sr3hoFoIx3tn1Ahonj5UWrYyWJlUEYIR
         zp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643375; x=1794248175;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:reply-to:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/HSK8bCv0QmKIxt+V6gWv55kxdgB1pVhBKVyk2Y6wxo=;
        b=au2cGt00mBQinB6rcgJO7NlpkBuB4oondhD7/38qx8xNFfyK5P8yyYqpTPwHypvHMO
         FzsFYvhWSJnNXq3DbfXyi/UHNiEZdjDjeu/3j5W25yhsyU9d8sDk0TsoTDgzshe7JoBz
         2GzG/OkQ51wrdHyfAHcz5ynsZZTfuLj6zG6KP/gltBRHs1I6GY4KkJtWNKAxyN6rvSsR
         4LnqjmGkDJwFNbeLQmiGGbx0ELc/nLJKdYU/N8G9nBumJq9UNp/4aJI1UvNH3U5LX7OE
         Zgcy0O2GBXocVopeEh8LNkoPCGmNJfGvyhydkhb8Sac6Fweix0hXTQLtE4w4QszhOBZZ
         OEIw==
X-Gm-Message-State: AFq9FYIopylnh8tf3BBqjmTi3OFHr13JLL1vGE0n7E4D5AdEE0t39+jW
	ak5ctRJ4Uw+9BuB+BQXyv6aC5lswA2j4tPlTYCMUBzN0rJXawdxx5UnofSGdDBLzP7VrH2uxvhM
	aXegS8IKGMIg=
X-Gm-Gg: AYBFou17Dm4KXuUVQiCKyMLx70xz4uIgdEq0+rLrsLsA3vNRsTw+wvoPBCB16aEkqcm
	S8Rp+KVINtEI951X814S26Liiw2gEPEWnXIB0WCqIR53L5woXeOkV0qMy026Os5EhVBk8uWBdRl
	98kEY+BGtt2YAW8IYmsdh7xLXhdluSbDNlJAQaliYJU/w6wLlXF5nmMAmyks9cZI0aePc8e9RvB
	SUhFro0U8PszYLLOMWOLQxr3drtvzifPa4q1SNGfigM/h6BpTdFL5d41fHBKTmGZGGHqM3u8z3Y
	GiyoioL76UMCxMxFwAIU7Svtr24Ac4eHe0AHxRCLV1JEx4uAekqUuOxzll2iQ0ad84uXBdSkF3W
	GTtcxNV6T2UucrWp/99Ww+s3bas2SJGKnyAGujRcKuXbX8LFZUFgotPa7XWYO+DBZrPUzm65Ndc
	XIhhwxt65OPA2RnHe3jXaEHju2zC7NlTLPG5UdeOGYOvFFnLav3H5UmMTbpmDggjDL6Kj5DjVs6
	NNyPxUdSCQy4x7EnPX47bVdVnOeIYtQjCZ7mJBPGZXPOmBU5IuqDKxwnd41DOoD5SU/wgZC/aMt
	OzeMefkPI+Ro2q+W+5rHdTmwW4e/dSGc4GUBIxZAlchs7PS4eLYbTlsHV7j9AqdQCiooEaFGUA7
	dtHE5+kBC3JY=
X-Received: by 2002:a05:620a:3942:b0:93b:d7a2:dd32 with SMTP id af79cd13be357-9442178e1edmr1642960885a.66.1793643375117;
        Mon, 02 Nov 2026 10:16:15 -0800 (PST)
Received: from realtoradnan.com (vmi3719414.contaboserver.net. [80.190.73.126])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425abd317sm895853785a.36.2026.11.02.10.16.13
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:16:14 -0800 (PST)
From: Troy Cross <troy@realtoradnan.com>
To: sched-ext@lists.linux.dev
Reply-To: Troy Cross <troy@realtoradnan.com>
Subject: schedkit
Message-ID: <2f393418-7255-4743-b185-248dbce5c845@realtoradnan.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:16:13 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Greetings,


Do you have any interest in=C2=A0schedkit .com for 500 usd? i =
noticed you own=C2=A0.io version, so maybe you will be interested in this =
one as well.


Sincerely,


Troy
